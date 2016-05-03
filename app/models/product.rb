class Product < ActiveRecord::Base
  include SlugGenerator

  validates_presence_of :title, :url, :image_url, :asin
  validates_uniqueness_of :asin
  
  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :product_showcases
  has_many :showcases, through: :product_showcases

  sluggable_column :title

  def self.lookup_asins_group_on_amazon(asin)
    search_asins_res = request_amazon('Variations', asin)
    res = OpenStruct.new
    asins = ""
    if search_asins_res.has_error?
      res.error = search_asins_res.error
    else
      search_asins_res.items[0..9].each do |item| # only use the first 10 ASINS
        asin = item.get('ASIN')
        asins << asin + ',' # Use ',' and no space " "
      end
      res.asins = asins.slice(0..-2)
    end
    return res
  end

  def self.lookup_items_on_amazon(response_group, asin)
    asins_group = lookup_asins_group_on_amazon(asin)
    if asins_group.error?
      return  asins_group.error #return the error msg
    else # request for details of each ASIN
      asins = asins_group.asins
      items_res = request_amazon(response_group, asins) # Performing Multiple ItemLookups in One Request (only upto 10 ASINS are allowed)
      
      res = OpenStruct.new
      res.product_details = []
      if items_res.has_error?
        res.error = items_res.error
      else
        items_res.items.each do |item|
          asin = item.get('ASIN')
          detail_page_url = item.get("DetailPageURL") #get the url to amazon detail page
          title = item.get('ItemAttributes/Title') #get title
          item_img = item.get_hash('LargeImage') #get large image url
          editorial_review = item.get_element('EditorialReview') # get description
          description = editorial_review.get('Content') # get description

          product_detail = {
            "asin"             => asin,
            "title"            => title,
            "detail_page_url"  => detail_page_url,
            "large_image_url"  => item_img["URL"],
            "description"      => description
          }

          product_detail = OpenStruct.new(product_detail)

          res.product_details << product_detail
        end
        return res
      end
    end
  end

  def self.lookup_price_on_amazon(response_group, asin, get_element, get_value)
    res = request_amazon(response_group, asin)
    extract_price(res, get_element, get_value)
  end


  def self.extract_price(response_group, get_element, get_value)
    price_list = response_group.get_element(get_element)
    if price_list.present?
      return price_list.get(get_value)
    else
      return "---"
    end
  end

  def self.request_amazon(response_group, asin)
    require 'amazon/ecs'

    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = ENV["AWS_ACCESS_KEY_ID"]
      options[:AWS_secret_key] = ENV["AWS_SECRET_ACCESS_KEY"]
      options[:associate_tag] = ENV["ASSOCIATE_TAG"]
    end
    res = Amazon::Ecs.item_lookup(asin, {:response_group => response_group})
    return res
    # TODO: uncomment these lines for amazon response debug output
    #count = @res.items.count
    #xml = @res.marshal_dump.gsub("\\n", "\n")
    #puts("Amazon response contains " + count.to_s + " item(s):\n\n" + xml)
  end
end
