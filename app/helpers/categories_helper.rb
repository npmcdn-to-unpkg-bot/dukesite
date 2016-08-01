module CategoriesHelper
  def no_products?(products)
    products.size == 0 ? true : false
  end
end