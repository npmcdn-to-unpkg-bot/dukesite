class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  def show
    prepare_meta_tags(@product)
    @price = Amazon::EcsWrapper.get_item_price('ItemAttributes', @product.asin, "ListPrice", "FormattedPrice")
  end

  private
    def prepare_meta_tags(object)
      @title = object.title
      @description = object.description
      # og
      # ------------------------------------------------------------------------------
      @image = object.image_url
      @image = SiteConfig.find_by(slug: "icon").photo.image.url if @image.nil?
      @og = { title: @title,
              type:  'website',
              url:  product_url(object),
              image:  @image }
      # keywords
      # ------------------------------------------------------------------------------
      keyword_entries = object.keywords
      @object_keywords = keyword_entries.map(&:value) if keyword_entries.present?
    end
    def find_product
      @product = Product.find_by(slug: params[:id])
      # Only published products can be seen on the shop
      # ------------------------------------------------------------------------------
      render :status => 404 if !@product.published || @product.nil?
    end
end