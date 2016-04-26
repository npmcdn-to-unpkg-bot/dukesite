class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  def show
    @price = Product.lookup_price_on_amazon('ItemAttributes', @product.asin, "ListPrice", "FormattedPrice")
  end
  private
    def find_product
      @product = Product.find_by(slug: params[:id])
      render :status => 404 if !@product.published || @product.nil?
    end
end