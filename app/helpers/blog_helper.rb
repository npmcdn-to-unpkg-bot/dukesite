module BlogHelper
  def no_articles?(articles)
    articles.size == 0 ? true : false
  end

  def previous_article?(article)
    previous_article(article).present? ? true : false
  end

  def next_article?(article)
    next_article(article).present? ? true : false
  end

  def previous_article_title(article)
    previous_article(article).title.truncate(27, separator: ' ')
  end

  def next_article_title(article)
    next_article(article).title.truncate(27, separator: ' ')
  end

  def previous_article(article)
    article.previous_article
  end

  def next_article(article)
    article.next_article
  end
end
