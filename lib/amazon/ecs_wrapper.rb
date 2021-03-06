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

    res_var = request_amazon({:response_group => "VariationMatrix"}, p_asin)
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
    res_attr = request_amazon({:response_group => "Medium"}, asin)
    # sort attributes
    res_attr.items.each do |node_item|
      item_asin = node_item.get("ASIN") if item_asin.nil?
      if items.has_key?(item_asin)
        items[item_asin].title = node_item.get("ItemAttributes/Title")
        items[item_asin].description = node_item.get("EditorialReviews/EditorialReview/Content")
        items[item_asin].brand = node_item.get("ItemAttributes/Brand")
        items[item_asin].detail_page_url = node_item.get("DetailPageURL")
        items[item_asin].image_url_large = node_item.get("LargeImage/URL")
        items[item_asin].image_url_small = node_item.get("MediumImage/URL")
      end
    end
  end

  def self.get_item_price(asin)
    #'ItemAttributes', @product.asin, "ListPrice", "FormattedPrice"

    # request Amazon price first
    res_price_amazon = request_amazon({:response_group => "ItemAttributes"}, asin)
    node_price = res_price_amazon.get_element("ListPrice")

    if !node_price.present?
      # request offer price if Amazon price is not available
      res_price_offer = request_amazon({:response_group => "OfferSummary"}, asin)
      node_price = res_price_offer.get_element("LowestNewPrice")
    end

    if node_price.present?
      return node_price.get("FormattedPrice")
    else
      return "---"
    end
  end

  def self.update_imgs(items)
    items.each do |item| 
      asin = item.asin
      res_imgs_amazon = request_amazon({:response_group => "Images"}, asin) 

      res_imgs_amazon.items.each do |return_item|
        item.image_url       = return_item.get("LargeImage/URL")
        item.image_url_small = return_item.get("MediumImage/URL")
        return false unless item.save
      end
    end
  end

  private
    # sends a request to Amazon Web Service using configured AWS credentials
    # returns: the corresponding Amazon::Ecs response
    def self.request_amazon(parameters, asin)
      Amazon::Ecs.configure do |options|
        options[:AWS_access_key_id] = ENV["AWS_ACCESS_KEY_ID_2"]
        options[:AWS_secret_key] = ENV["AWS_SECRET_ACCESS_KEY_2"]
        options[:associate_tag] = ENV["ASSOCIATE_TAG"]
      end
      
      # Retry for 3 times if request error (503) exists
      request_times = 0
      begin
       result = Amazon::Ecs.item_lookup(asin, parameters)
      rescue Amazon::RequestError => error
        if /503/ =~ error.message && request_times < 3
          sleep 3
          request_times += 1
          puts asin + " => Request times: " + request_times.to_s
          retry
        else
          raise error
        end
      end

      return result
    end

    # requests the parent ASIN for a given ASIN
    # returns: the parent ASIN
    def self.request_parent_asin(asin)
      p_asin = nil

      res_id = request_amazon({:response_group => "ItemIds"}, asin)
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
