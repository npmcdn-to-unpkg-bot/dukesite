class Admin::BlogController < AdminController
  def index
    @articles = Article.all.order("updated_at DESC")
  end
end