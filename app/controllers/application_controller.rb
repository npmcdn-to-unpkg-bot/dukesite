class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :prepare_meta_tags, if: "request.get?"
  before_action :get_default_variables
  protect_from_forgery with: :exception
  layout :layout_by_resource

  private
    def prepare_meta_tags( options = {} )
      site_name   = SiteConfig.find_by(slug: "site-name").value
      title       = options[:title] || SiteConfig.find_by(slug: "site-name").value
      description = SiteConfig.find_by(slug: "description").value
      carousel    = Carousel.visible
      image       = carousel.map(&:photo).map(&:image).map(&:url)
      icon        = SiteConfig.find_by(slug: "icon").photo
      image << icon.image.thumb.url if (icon.image.present? && !icon.image.url.nil?)
      current_url = request.url

      # # keywords
      # # ------------------------------------------------------------------------------
      keyword_entries = SiteConfig.find_by(slug: "seo").keywords
      keywords = keyword_entries.map(&:value) if keyword_entries.present?

      # # og
      # # ------------------------------------------------------------------------------
      @og = { title: @title,
              type:  'website',
              image: image,
              url:   current_url
            }

      # # favicon
      # ------------------------------------------------------------------------------# favicon
      favicon = SiteConfig.find_by(slug: "favorite-icon").photo
      favicon = favicon.image.url if (favicon.image.present? && !favicon.image.url.nil?)

      defaults = {
        site:        site_name,
        title:       title,
        image:       image,
        icon:        favicon,
        description: description,
        canonical:   current_url,
        keywords:    keywords,
        og:          {url: current_url,
                      site_name: site_name,
                      title: title,
                      image: image,
                      description: description,
                      type: 'website'}
      }
      options.reverse_merge!(defaults)
      set_meta_tags options
    end

    def get_default_variables
      @our_belief = SiteConfig.find_by(key: "Our Belief").value
      # icon
      # ------------------------------------------------------------------------------
      icon = SiteConfig.find_by(slug: "icon").photo
      icon.nil? ? @icon = "http://thedudeminds.de/images/thedukegirls.png" : @icon = icon.image.url

      @categories = Category.visible
      @showcases = Showcase.visible_on_landing_page
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
