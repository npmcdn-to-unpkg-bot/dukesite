class ShowcasesController < ApplicationController
  before_action :find_showcase, only: [:show]
  def show
    # Only published products can be seen on the shop
    # ------------------------------------------------------------------------------
    @products = @showcase.products.where(published: true).order("updated_at DESC")
    # meta-tags
    # ------------------------------------------------------------------------------
    title       = @showcase.title
    description = @showcase.subtitle
    image       = @showcase.products.where(published: true).order("updated_at DESC")[0..5].map(&:image_url)
    image       << @showcase.photo.image.thumb.url if (@showcase.photo.present? && !@showcase.photo.image.url.nil?)
    keywords    = @showcase.keywords.map(&:value) if @showcase.keywords.present?

    prepare_meta_tags  title:       title,
                       keywords:    keywords,
                       image:       image,
                       og: { title:       title,
                             description: description,
                             image:       image }
  end

  private
    def find_showcase
      @showcase = Showcase.find_by(slug: params[:id], visible: true)
    end
end