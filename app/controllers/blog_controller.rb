class BlogController < ApplicationController
  before_action :find_article, only: [:show]
  def index
    # only published articles can be shown in the blog
    # ------------------------------------------------------------------------------
    @articles = Article.published.order("published_at DESC")
  end
  def show
    # meta-tags
    # ------------------------------------------------------------------------------
    title       = @article.title
    subtitle    = @article.subtitle
    image       = @article.photo.image.url if (!@article.photo.nil? && !@article.photo.image.url.nil?)
    keywords    = @article.keywords.map(&:value) if @article.keywords.present?
    
    prepare_meta_tags  title:       title,
                       description: subtitle,
                       keywords:    keywords,
                       image:       image,
                       og: { title:       title,
                             description: subtitle,
                             image:       image
                           }
  end

  private
    def find_article
      # Only published article can be shown in the blog
      # ------------------------------------------------------------------------------
      @article = Article.find_by(slug: params[:id], published: true)
    end
end