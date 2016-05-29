class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]
  def show
    @products = @category.products.where(published: true).order("updated_at DESC")
    # meta-tags
    # ------------------------------------------------------------------------------
    title       = @category.name
    image       = @category.products.where(published: true).order("updated_at DESC")[0..5].map(&:image_url)
    image       << @category.photo.image.thumb.url if (@category.photo.present? && !@category.photo.image.url.nil?)
    keywords    = @category.keywords.map(&:value) if @category.keywords.present?
    
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