class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]
  def show
    @products = @category.published_products_desc
    # meta-tags
    # ------------------------------------------------------------------------------
    title       = @category.name
    image       = @category.published_products_desc[0..5].map(&:image_url)
    image       << @category.thumb_img_url(:show_no_image_available => false)
    keywords    = @category.valid_keywords
    
    prepare_meta_tags  title:       title,
                       keywords:    keywords,
                       image:       image,
                       og: { title:       title,
                             image:       image
                           }
  end
  private
    def find_category
      @category = Category.find_by(slug: params[:id], visible: true)
    end
end