class Admin::SiteConfigsController < AdminController
  def index
    @site_configs = SiteConfig.web_settings
    @seo = SiteConfig.find_by(slug: "seo")
    # Favorite Icon
    @favicon = SiteConfig.find_by(slug: "favorite-icon")
    ## Show existed icon img
    if @favicon.photo.nil?
      @favicon.photo = Photo.new
    else
      @favicon_img_url = @favicon.photo.image.url
    end
    
    # Icon
    @icon = SiteConfig.find_by(slug: "icon")
    ## Show existed icon img
    if @icon.photo.nil?
      @icon.photo = Photo.new
    else
      @icon_img_url = @icon.photo.image.url
    end

    # Keywords
    @keywords = @seo.keywords.where.not(value: nil).order("created_at DESC")
  end

  def update 
    if params["site_configs"].present?
      params["site_configs"].each do |key, value|
        site_config = SiteConfig.find_by(slug: key)
        site_config.update(value.permit(:value))
      end
    else
      find_site_config
      @site_config.update(site_config_params)
    end
    flash[:success] = "Successfully updated."
    redirect_to admin_site_configs_path
  end

  def site_config_params
    params.require(:site_config).permit(photo_attributes: [:image])
  end

  def find_site_config
    @site_config = SiteConfig.find_by(slug: params[:id])
  end
end