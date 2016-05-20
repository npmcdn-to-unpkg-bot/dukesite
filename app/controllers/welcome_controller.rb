class WelcomeController < ApplicationController
  def index
    @visible_carousels = Carousel.visible.order("updated_at DESC")
  end

  def our_stroy
  end

  def join_us
  end
end
