class Admin::SiteConfigsController < AdminController
  def index
    @site_configs = SiteConfig.web_settings
    @seo = SiteConfig.find_by(slug: "seo")
    @keywords = @seo.keywords.where.not(value: nil).order("created_at DESC")
  end

  def update 
    params["site_configs"].each do |key, value|
      site_config = SiteConfig.find_by(slug: key)
      site_config.update(value.permit(:value))
    end
    flash[:success] = "Successfully updated."
    redirect_to admin_site_configs_path
    # else
    #   render :index
    # end
  end

  def keyword_params
    params.require(:keyword).permit(:value)
  end
end