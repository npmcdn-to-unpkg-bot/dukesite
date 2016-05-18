class WelcomeController < ApplicationController
  def index
    @visible_carousels = Carousel.where(visible: true)
  end

  def our_stroy
  end

  def join_us
  end
end
