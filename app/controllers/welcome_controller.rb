class WelcomeController < ApplicationController
  def index
    @carousel_imgs = Product.where(carousel: true)
    @showcases = Showcase.all.where(:show_on_landing_page => true)
  end
end
