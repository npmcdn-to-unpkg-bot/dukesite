class ShowcasesController < ApplicationController
  before_action :find_showcase, only: [:show]
  def show
    # Only published products can be seen on the shop
    # ------------------------------------------------------------------------------
    prepare_meta_tags(@showcase)
    @products = @showcase.products.where(published: true).order("updated_at DESC")
  end

  private
    def prepare_meta_tags(object)
      @title = object.title
      # keywords
      # ------------------------------------------------------------------------------
      keyword_entries = object.keywords
      @object_keywords = keyword_entries.map(&:value) if keyword_entries.present?
    end
    def find_showcase
      @showcase = Showcase.find_by(slug: params[:id])
      render :status => 404 if !@showcase.visible || @showcase.nil?
    end
end