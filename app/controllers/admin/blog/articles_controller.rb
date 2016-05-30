class Admin::Blog::ArticlesController < AdminController
  before_action :find_article, only: [:show, :edit, :update, :delete]
  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "An article was successfully created."
      redirect_to admin_articles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "The article was successfully updated."
      redirect_to admin_articles_path(@article)
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "The article was successfully deleted."
      redirect_to admin_articles_path
    else
      render :show
    end
  end

  private
    def find_article
      @article = Article.find_by(slug: params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :subtitle, :content)
    end
end
