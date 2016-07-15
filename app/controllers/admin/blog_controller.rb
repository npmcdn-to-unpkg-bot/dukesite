class Admin::BlogController < AdminController
  def index
    @articles_amount = Article.all.length
    @articles = Article.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 12)
  end
end