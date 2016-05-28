class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]
  def show
    @products = @category.products.where(published: true).order("updated_at DESC")
    # meta-tags
    # ------------------------------------------------------------------------------
    title       = @category.title
    image       = @category.photo.image.thumb.url if (@category.photo.present? && !@category.photo.image.url.nil?)
    keywords    = @category.keywords.map(&:value) if @category.keywords.present?
    
    prepare_meta_tags  title:       title,
                       keywords:    keywords,
                       og: { title:       title,
                             description: description,
                             image:       image
                           }
  end

  private

    def find_category
      @category = Category.find_by(slug: params[:id])
      render :status => 404 if !@category.visible || @category.nil?
    end
end