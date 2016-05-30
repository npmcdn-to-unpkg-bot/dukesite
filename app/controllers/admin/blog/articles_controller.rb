class Admin::Blog::ArticlesController < AdminController
  before_action :find_article, only: [:show, :edit, :update, :delete, :publish_switch]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "An article was successfully created."
      redirect_to admin_blog_index_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "An Article was successfully updated."
      redirect_to admin_blog_index_path
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "An Article was successfully deleted."
      redirect_to admin_blog_index_path
    else
      render :show
    end
  end

  def publish_switch
    status = 200
    response = ""
    if @article.update_attributes(published: params[:published], published_at: Time.now)
      flash[:success] = "Successfully updated."
      article_status = @article.published
    else
      status = 404
      response = "Please try again"
    end
    render json: { response: response, article_status: article_status },
           status: status
  end

  private
    def find_article
      @article = Article.find_by(slug: params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :subtitle, :content)
    end
end
