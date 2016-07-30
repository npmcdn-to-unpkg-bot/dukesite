module Admin::ProductsHelper
  def product_image_tag(product)
    product.image_url.nil? ? img_url = 'http://thedudeminds.de/images/no_image_available.png' : img_url = @product.image_url
    image_tag img_url, class: "img-responsive thumbnail", id: "product-img-url"
  end
end