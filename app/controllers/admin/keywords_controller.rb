class Admin::KeywordsController < AdminController
  before_action :find_keyword, only: [:destroy]
  def create
    status = 200
    response = ""
    parent_object = SiteConfig.find_by(slug: params[:site_config_id]) if params[:site_config_id] != nil
    parent_object = Product.find_by(slug: params[:product_id]) if params[:product_id] != nil
    parent_object = Category.find_by(slug: params[:category_id]) if params[:category_id] != nil
    parent_object = Showcase.find_by(slug: params[:showcase_id]) if params[:showcase_id] != nil

    keyword = parent_object.keywords.new(keyword_params)
    if keyword.save
      keyword = keyword.value
    else
      status = 404
      response = "Please try again."
    end
    render json: { response: response},
           status: status
  end

  def destroy
    status = 200
    response = ""
    unless @keyword.destroy
      status = 404
      esponse = "Please try again."
    end
    render json: { response: response },
           status: status
  end

  private
    def keyword_params
      params.require(:keyword).permit(:value)
    end

    def find_keyword
      @keyword = Keyword.find_by(slug: params[:id])
    end
end
