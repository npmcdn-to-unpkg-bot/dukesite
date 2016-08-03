module Admin::BlogHelper
  def article_create_time(article)
    article.created_at.nil? ? 'Not Saved Yet' : article.created_at.to_formatted_s(:long)
  end

  def article_update_time(article)
    article.updated_at.nil? ? 'Not Saved Yet' : article.updated_at.to_formatted_s(:long)
  end
end
