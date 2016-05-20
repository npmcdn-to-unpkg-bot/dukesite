class Admin::CarouselsController < AdminController
  before_action :find_carousel, only: [:edit, :show, :update, :destroy, :visible_switch]
  before_action :find_all_carousels, only: [:index, :create]
  def index
    @carousel = Carousel.new
    @carousel.photo = Photo.new
    @carousel_img_url = nil
  end

  def create
    @carousel = Carousel.new(carousel_params)
    if @carousel.save
      flash[:success] = "A new quote was succefully created."
      redirect_to admin_carousels_path
    else
      render :index
    end
  end

  def edit
    @carousel_img_url = @carousel.photo.image.url
  end

  def update
    if @carousel.update(carousel_params)
      flash[:success] = "successfully edited."
      redirect_to admin_carousels_path
    else
      render :edit
    end
  end

  def visible_switch
    status = 200
    response = ""
    if @carousel.update_attribute(:visible, params[:visible])
      flash[:success] = "Successfully updated."
      carousel_status = @carousel.visible
    else
      status = 404
      response = "Please try again"
    end
    render json: { response: response, carousel_status: carousel_status },
           status: status
  end

  def destroy
    @carousel.destroy
    flash[:success] = "The carousel was successfully deleted."
    redirect_to admin_carousels_path
  end

  private
    def find_carousel
      @carousel = Carousel.find_by(slug: params[:id])
    end
    def carousel_params
      params.require(:carousel).permit(:title, :description, photo_attributes: [:image])
    end

    def find_all_carousels
      @carousels = Carousel.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    end
end