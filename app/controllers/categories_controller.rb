class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]
  def show
    prepare_meta_tags(@category)
    @products = @category.products.where(published: true).order("updated_at DESC")
  end

  private
    def prepare_meta_tags(object)
      @title = object.name
      # og
      # ------------------------------------------------------------------------------
      @image = object.photo.image.url if object.photo.present?
      @og = { title: @title,
              type:  'website',
              url:  category_url(object),
              image:  @image }
      # keywords
      # ------------------------------------------------------------------------------
      keyword_entries = object.keywords
      @object_keywords = keyword_entries.map(&:value) if keyword_entries.present?
    end
    def find_category
      @category = Category.find_by(slug: params[:id])
      render :status => 404 if !@category.visible || @category.nil?
    end
end