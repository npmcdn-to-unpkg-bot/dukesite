class Admin::Blog::ArticlesController < AdminController
  before_action :find_article, only: [:show, :edit, :update, :delete, :publish_switch]

  def new
    @article = Article.new
    @article.photo = Photo.new
  end

  def create
    if !params[:article][:photo_attributes].nil?
      if Article.create(article_params(:update_photo => true))
        flash[:success] = "An article was successfully created."
        redirect_to admin_blog_index_path
      else
        flash[:danger] = "Please try again."
        render :new
      end
    elsif Article.create(article_params)
      flash[:success] = "An article was successfully created."
      redirect_to admin_blog_index_path
    else
      flash[:danger] = "Please try again."
      render :new
    end
  end

  def edit
    @article.photo = Photo.new if @article.photo.nil?
    @thumb_img_url = @article.thumb_img_url
  end

  def update
    if !params[:article][:photo_attributes][:image].nil?
      if @article.update(article_params(:update_photo => true))
        flash[:success] = "An Article was successfully updated."
        redirect_to admin_blog_index_path
      else
        flash[:danger] = "Please try again."
        render :edit
      end
    elsif @article.update(article_params)
      flash[:success] = "An Article was successfully updated."
      redirect_to admin_blog_index_path
    else
      flash[:danger] = "Please try again."
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

    def article_params(options = {:update_photo => false})
      if options[:update_photo]
        params.require(:article).permit(:title, :subtitle, :content, photo_attributes: [:image])
      else
        params.require(:article).permit(:title, :subtitle, :content)
      end
    end
end
