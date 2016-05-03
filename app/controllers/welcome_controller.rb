class WelcomeController < ApplicationController
  def index
    @carousel_imgs = Photo.where(carousel: true)
  end

  def our_stroy
  end
end
