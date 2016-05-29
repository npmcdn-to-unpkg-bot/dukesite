class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  def show
    @price = Amazon::EcsWrapper.get_item_price(@product.asin)
    # meta-tags
    # ------------------------------------------------------------------------------
    title       = @product.title
    description = @product.description
    image       = @product.image_url
    keywords = @product.keywords.map(&:value) if @product.keywords.present?

    prepare_meta_tags title:       title,
                      description: description,
                      keywords:    keywords,
                      image:       image,
                      og: { title:       title,
                            description: description,
                            image:       image }
  end

  private
    def find_product
      @product = Product.find_by(slug: params[:id])
      # Only published products can be seen on the shop
      # ------------------------------------------------------------------------------
      render :status => 404 if !@product.published || @product.nil?
    end
end
