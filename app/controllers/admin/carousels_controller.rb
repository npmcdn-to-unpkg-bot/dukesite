class Admin::CarouselsController < AdminController
  def index
    @carousels = Carousel.all.order("updated_at DESC")
  end
end