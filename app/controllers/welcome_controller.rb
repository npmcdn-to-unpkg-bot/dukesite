class WelcomeController < ApplicationController
  def index
    @carousel_imgs = Image.where(carousel: true)
    @showcases = Showcase.all
  end
end
