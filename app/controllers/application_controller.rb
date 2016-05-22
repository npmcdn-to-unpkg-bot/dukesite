class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :default_meta_tags, if: "request.get?"
  before_action :get_visible_category, :get_landing_page_showcase, :get_social_network_account, :layout_text
  protect_from_forgery with: :exception
  layout :layout_by_resource

  def create_subscriber
    status   = 200
    response = ""
    if params[:email].blank?
      status   = 400
      response = "Please enter email address."
    else
      @subscriber = Subscriber.create(email: params[:email])
      response = "You've subscirbed Newsletter from Duke for Girls."
    end
    render json: {response: response},
           status: status
  end

  private
    def default_meta_tags
      @site_name = SiteConfig.find_by(slug: "site-name").value
      @description = SiteConfig.find_by(slug: "description").value
      # favicon
      favicon = SiteConfig.find_by(slug: "favorite-icon").photo
      favicon.nil? ? @favicon = "" : @favicon = favicon.image.url
      # keywords
      keyword_entries = SiteConfig.find_by(slug: "seo").keywords
      keyword_entries.nil? ? @keywords = "" : @keywords = keyword_entries.map(&:value)
    end

    def layout_text
      @our_belief = SiteConfig.find_by(key: "Our Belief").value
      # icon
      icon = SiteConfig.find_by(slug: "icon").photo
      icon.nil? ? @icon = "http://thedudeminds.de/images/thedukegirls.png" : @icon = icon.image.url
    end

    def get_visible_category
      @categories = Category.visible
    end

    def get_landing_page_showcase
      @showcases = Showcase.visible_on_landing_page
    end

    def get_social_network_account
      @visible_snas = SocialNetworkAccount.visible
    end
    
    def layout_by_resource
    if devise_controller? && resource_name == :admin
      "devise"
    else
      "application"
    end
  end
end
