class Admin::ProductsController < AdminController
  def index
    @products = Product.all.order("updated_at DESC")
  end
end
