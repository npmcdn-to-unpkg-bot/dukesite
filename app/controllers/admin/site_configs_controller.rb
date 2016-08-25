class Admin::SiteConfigsController < AdminController
  before_action :find_site_config, only: [:edit]
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

    #Out Story & Join US
    @site_intros = SiteConfig.site_intros
  end

  def edit
  end

  def update
    if params["site_configs"].present?
      params["site_configs"].each do |key, value|
        site_config = SiteConfig.find_by(slug: key)
        site_config.update(value.permit(:value))
      end
    else
      find_site_config
      if params[:id] == ("our-story" || "join-us")
        if @site_config.update(site_config_params)
          flash[:success] = "Successfully updated."
          redirect_to admin_site_configs_path
        else
          flash[:error] = "Please try again."
          render :back
        end
      elsif @site_config.update(site_config_params(:update_photo => true))
        flash[:success] = "Successfully updated."
        redirect_to admin_site_configs_path
      else
        flash[:error] = "Please try again."
        render :back
      end
    end
  end

  def site_config_params(options = { :update_photo => false })
    if options[:update_photo]
      params.require(:site_config).permit(:value, photo_attributes: [:image])
    else
      params.require(:site_config).permit(:value)
    end
  end

  def find_site_config
    @site_config = SiteConfig.find_by(slug: params[:id])
  end
end