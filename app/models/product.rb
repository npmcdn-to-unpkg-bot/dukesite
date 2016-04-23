class Product < ActiveRecord::Base
  include SlugGenerator

  validates_presence_of :title, :url, :image_url
  validates_uniqueness_of :asin

  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :product_showcases
  has_many :showcases, through: :product_showcases

  sluggable_column :title

  def self.lookup_asins_group_on_amazon(asin)
    search_asins_res = Amazon::EcsWrapper.request_amazon('Variations', asin)
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
    tmp = Amazon::EcsWrapper.get_item_group(asin)
    byebug

    lookup_asins_res = lookup_asins_group_on_amazon(asin)
    if lookup_asins_res.error?
      return  lookup_asins_res
    else
      product_details = []
      asins = lookup_asins_res.asins
      items_res = Amazon::EcsWrapper.request_amazon(response_group, asins) # Performing Multiple ItemLookups in One Request (only upto 10 ASINS are allowed)
      res = OpenStruct.new
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
          product_details << product_detail
          res.product_details = product_details
        end
        return res
      end
    end
  end
end
