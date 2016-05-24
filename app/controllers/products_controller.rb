class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  def show
    @price = Amazon::EcsWrapper.get_item_price('ItemAttributes', @product.asin, "ListPrice", "FormattedPrice")
  end
  private
    def find_product
      @product = Product.find_by(slug: params[:id])
      # Only published products can be seen on the shop
      # ------------------------------------------------------------------------------
      render :status => 404 if !@product.published || @product.nil?
    end
end