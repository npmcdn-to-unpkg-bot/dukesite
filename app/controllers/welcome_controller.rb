class WelcomeController < ApplicationController
  def index
    @carousel_imgs = Product.where(carousel: true)
    @showcases = Showcase.all
  end
end
