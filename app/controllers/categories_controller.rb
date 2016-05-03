class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]
  def show
    @products = @category.products.where(published: true).order("updated_at DESC")
  end

  private
    def find_category
      @category = Category.find_by(slug: params[:id])
      render :status => 404 if !@category.visible || @category.nil?
    end
end