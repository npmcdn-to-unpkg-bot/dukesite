class WelcomeController < ApplicationController
  def index
    @carousel_imgs = Image.where(set_as_carousel: true)
  end

  def our_stroy
  end
end
