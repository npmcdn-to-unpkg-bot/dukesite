module Admin::BlogHelper
  def published_article?(article)
    'invisible_thumbnail' if !article.published
  end
end