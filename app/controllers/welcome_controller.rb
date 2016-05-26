class WelcomeController < ApplicationController
  def index
    @visible_carousels = Carousel.visible.order("updated_at DESC")
  end

  def our_story
    @our_story = SiteConfig.find_by(slug: "our-story").value 
  end

  def join_us
    @join_us = SiteConfig.find_by(slug: "join-us").value 
  end
end
