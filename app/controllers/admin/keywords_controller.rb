class Admin::KeywordsController < AdminController
  before_action :find_keyword, only: [:destroy]
  def create
    status = 200
    response = ""

    if params[:site_config_id].present?
      byebug
      site_config = SiteConfig.find_by(slug: params[:site_config_id])
      keyword = site_config.keywords.new(keyword_params)
      if keyword.save
        keyword = keyword.value
        delete_url = admin_site_config_keyword_path(site_config, keyword)
      else
        status = 404
        response = "Please try again."
      end
    elsif params[:product_id].present?
      product = Product.find_by(slug: params[:product_id])
      keyword = product.keywords.new(keyword_params)
      if keyword.save
        keyword = keyword.value
        delete_url = admin_product_keyword_path(product, keyword)
      else
        status = 404
        response = "Please try again."
      end
    end
    render json: { response: response, new_keyword: keyword, url: delete_url },
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
