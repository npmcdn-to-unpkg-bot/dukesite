class Admin::CarouselsController < AdminController
  before_action :find_carousel, only: [:edit, :update, :destroy, :visible_switch]
  before_action :find_carousel_by_carousel_id, only: [:update_image]
  before_action :find_all_carousels, only: [:index, :create]

  def index
    @carousel = Carousel.new
    @carousel.photo = Photo.new
    @thumb_img_url = @carousel.thumb_img_url
  end

  def create
    # Create photo when an image is uploaded.
    if !params[:carousel][:photo_attributes].nil?
      @carousel = Carousel.new(carousel_params(:update_photo => true))
    else # Don't create photo if no image is uploaded.
      @carousel = Carousel.new(carousel_params)
    end
    if @carousel.save
      flash[:success] = "successfully updated."
      redirect_to admin_carousels_path
    else
      @carousel.photo = Photo.new
      @thumb_img_url = @carousel.thumb_img_url
      render :index
    end
  end

  def edit
    if @carousel.photo.nil?
      @carousel.photo = Photo.new
    else
      @thumb_img_url = @carousel.thumb_img_url
    end
  end

  def update
    # Don't update photo attributes if no image is uploaded.
    if !params[:carousel][:photo_attributes][:image].nil?
      if @carousel.update(carousel_params(:update_photo => true))
        flash[:success] = "Successfully updated."
        redirect_to admin_carousels_path
      else
        flash[:danger] = "Please try again."
        render :edit
      end
    elsif @carousel.update(carousel_params)
      flash[:success] = "Successfully updated."
      redirect_to admin_carousels_path
    else
      flash[:danger] = "Please try again."
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

  def update_image
    if params[:carousel].present? && @carousel.photo.update(photo_params)
      flash[:success] = "A new image was succefully uploaded."
      redirect_to edit_admin_carousel_path(@carousel)
    else
      flash[:danger] = "Please try again."
      render :edit
    end
  end

  def destroy
    @carousel.destroy
    flash[:success] = "The carousel was successfully deleted."
    redirect_to admin_carousels_path
  end

  private
    def photo_params
      params.require(:carousel).permit(:image)
    end

    def find_carousel
      @carousel = Carousel.find_by(slug: params[:id])
    end
    
    def carousel_params(options = {:update_photo => false})
      if options[:update_photo] 
        params.require(:carousel).permit(:title, :description, photo_attributes: [:image])
      else
        params.require(:carousel).permit(:title, :description)
      end
    end

    def find_carousel_by_carousel_id
      @carousel = Carousel.find_by(slug: params[:carousel_id])
    end

    def find_all_carousels
      @carousels = Carousel.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    end
end