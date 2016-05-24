class ShowcasesController < ApplicationController
  before_action :find_showcase, only: [:show]
  def show
    # Only published products can be seen on the shop
    # ------------------------------------------------------------------------------
    @products = @showcase.products.where(published: true).order("updated_at DESC")
  end

  private
    def find_showcase
      @showcase = Showcase.find_by(slug: params[:id])
      render :status => 404 if !@showcase.visible || @showcase.nil?
    end
end