class WelcomeController < ApplicationController
  def index
    @carousel_imgs = Image.where(set_as_carousel: true)
    @showcases = Showcase.all.where(:show_on_landing_page => true)
  end
end
