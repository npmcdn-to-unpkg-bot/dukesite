class Admin::BlogController < AdminController
  def index
    @articles = Article.all.order("created_at DESC")
  end
end