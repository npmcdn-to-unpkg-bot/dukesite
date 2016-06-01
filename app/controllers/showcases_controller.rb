class ShowcasesController < ApplicationController
  before_action :find_showcase, only: [:show]
  def show
    # meta-tags
    # ------------------------------------------------------------------------------
    title       = @showcase.title
    description = @showcase.subtitle
    image       = @showcase.published_products[0..5].map(&:image_url)
    image       << @showcase.thumb_img_url
    keywords    = @showcase.valid_keywords

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