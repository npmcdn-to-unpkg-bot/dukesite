# Ruby gem jugend/amazon-ecs provides module Amazon for requests to Amazon
# Web Service
module Amazon
  # This class is wrapping the Amazon::Ecs class and provides functionality
  # tailored to the needs of the 'dukesite' app
  class EcsWrapper

  def self.get_item_group(asin)
    items = Hash.new

    # request parent ID from Amazon
    p_asin = request_parent_asin(asin)
    return p_asin unless p_asin.is_a? String

    res_var = request_amazon("VariationMatrix", p_asin)
    raise res_var.error if res_var.has_error?
    return items if res_var.items.count == 0

    res_items_amout = res_var.items.count
    case res_items_amout
    when 0
      return items
    when 1
      node_var = res_var.get_element("Item")

      item_asin = node_var.get("ASIN")
      items[item_asin] = AmazonItem.new(
        asin: item_asin
      )
      # get the attributes of each item
      get_item_attributes(item_asin, items)
    else
      # request variation matrix from Amazon
      # get all colors from variation matrix
      # create AmazonItem objects for each color
      node_var = res_var.get_element("Item/Variations")
      node_var.get_elements("Item").each do |var_item|
        item_asin = var_item.get("ASIN")
        item_color = var_item.get("VariationAttributes/VariationAttribute[Name='Color']/Value")
        item_color = "" if item_color.nil?

        if items.select {|id,item| item.color == item_color}.length == 0
          items[item_asin] = AmazonItem.new(
            asin: item_asin,
            color: item_color
          )
        end
      end
      # split AmazonItem ASINs into request strings (max. 10 per request)
      request_strings = split_asins(items.keys, 10)

      # request additional data for each ASIN and add to AmazonItem objects
      request_strings.each do |s|
        # get the attributes of each item
        get_item_attributes(s, items)
      end
    end

    return items
  end

  def self.get_item_attributes(asin, items)
    # get data from 'Medium' request
    res_attr = request_amazon("Medium", asin)
    # sort attributes
    res_attr.items.each do |node_item|
      item_asin = node_item.get("ASIN") if item_asin.nil?
      if items.has_key?(item_asin)
        items[item_asin].title = node_item.get("ItemAttributes/Title")
        items[item_asin].description = node_item.get("EditorialReviews/EditorialReview/Content")
        items[item_asin].brand = node_item.get("ItemAttributes/Brand")
        items[item_asin].detail_page_url = node_item.get("DetailPageURL")
        items[item_asin].image_url_large = node_item.get("LargeImage/URL")
        items[item_asin].image_url_small = node_item.get("SmallImage/URL")
      end
    end
  end

  def self.get_item_price(response_group, asin, get_element, get_value)
    res_price = request_amazon(response_group, asin)

    price_list = res_price.get_element(get_element)
    if price_list.present?
      return price_list.get(get_value)
    else
      return "---"
    end
  end


  def self.extract_price(response_group, get_element, get_value)
  end

  private
    # sends a request to Amazon Web Service using configured AWS credentials
    # returns: the corresponding Amazon::Ecs response
    def self.request_amazon(response_group, asin)
      Amazon::Ecs.configure do |options|
        options[:AWS_access_key_id] = ENV["AWS_ACCESS_KEY_ID"]
        options[:AWS_secret_key] = ENV["AWS_SECRET_ACCESS_KEY"]
        options[:associate_tag] = ENV["ASSOCIATE_TAG"]
      end

      return Amazon::Ecs.item_lookup(asin, {:response_group => response_group})
    end

    # requests the parent ASIN for a given ASIN
    # returns: the parent ASIN
    def self.request_parent_asin(asin)
      p_asin = nil

      res_id = request_amazon("ItemIds", asin)
      if res_id.has_error?
        return res_id 
      else 
        p_asin = res_id.items[0].get("ParentASIN") if res_id.items.count >= 1
        return p_asin
      end
    end

    def self.split_asins(list_asin, max_length)
      asin_strings = Array.new

      i_max = (list_asin.length - 1) / max_length
      for i in 0..i_max do
        idx_start = i * max_length
        idx_end = [idx_start + max_length, list_asin.length].min - 1

        asin_strings << list_asin[idx_start..idx_end].join(",")
      end

      return asin_strings
    end
  end

  class AmazonItem
    include ActiveModel::Model

    attr_accessor :asin,
                  :title,
                  :description,
                  :brand,
                  :color,
                  :detail_page_url,
                  :image_url_large,
                  :image_url_small

    validates_presence_of :asin

  end
end
