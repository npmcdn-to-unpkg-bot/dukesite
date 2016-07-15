class Admin::ShowcasesController < AdminController
  before_action :find_showcase, only: [:show, :edit, :update, :destroy, :visible_switch]
  before_action :find_showcase_by_showcase_id, only: [:update_image]

  before_action :find_all_showcases, only: [:index, :create]
  def index
    @showcase = Showcase.new
    @showcase.photo = Photo.new
    @thumb_img_url = @showcase.photo.image.thumb.url
  end

  def show
    if @showcase.photo.present?
      @thumb_img_url = @showcase.photo.image.thumb.url 
    else
      @showcase.photo = Photo.new
    end
    # Here, we must use paginate method to create @products,
    # so the front end can get data for the pagination.
    @keywords = @showcase.keywords.where.not(value: nil).order("created_at DESC")
    @products = @showcase.products.paginate(:page => params[:page], :per_page => 12)
  end

  def create
    # Don't create photo if no image is uploaded.
    if !params[:showcase][:photo_attributes].nil?
      @showcase = Showcase.new(showcase_params(:update_photo => true))
    else
      @showcase = Showcase.new(showcase_params)
    end
    if @showcase.save
      flash[:success] = "A showcase was successfully created."
      redirect_to admin_showcases_path
    else
      flash[:danger] = "Please try again."
      @showcase.photo = Photo.new
      @thumb_img_url = @showcase.photo.image.thumb.url
      render :index
    end
  end

  def edit
  end

  def update
    # Don't update photo attributes if no image is uploaded.
    if !params[:showcase][:photo_attributes].nil?
      if @showcase.update(showcase_params(:update_photo => true))
        flash[:success] = "Successfully updated."
        redirect_to admin_showcase_path(@showcase)
      else
        flash[:danger] = "Please try again."
        render :edit
      end
    elsif @showcase.update(showcase_params)
      flash[:success] = "Successfully updated."
      redirect_to admin_showcase_path(@showcase)
    else
      flash[:danger] = "Please try again."
      render :edit
    end
  end

  def visible_switch
    status = 200
    response = ""
    if @showcase.update_attribute(:visible, params[:visible])
      flash[:success] = "Successfully updated."
      showcase_status = @showcase.visible
    else
      status = 404
      response = "Please try again."
    end
    render json: { response: response, showcase_status: showcase_status },
           status: status
  end

  def update_image
    if params[:showcase].present? && @showcase.photo.update(photo_params)
      flash[:success] = "A new image was succefully uploaded."
      redirect_to admin_showcase_path(@showcase)
    else
      flash[:danger] = "Please try again."
      render :product_list
    end
  end

  def destroy
    @showcase.destroy
    flash[:success] = "The showcase was successfully deleted."
    redirect_to admin_showcases_path
  end

  private
    def photo_params
      params.require(:showcase).permit(:image)
    end
    
    def showcase_params(options = {:update_photo => false})
      if options[:update_photo] 
        params.require(:showcase).permit(:title, :subtitle, :show_on_landing_page, :visible, photo_attributes: [:image])
      else
        params.require(:showcase).permit(:title, :subtitle, :show_on_landing_page, :visible)
      end
    end

    def find_showcase
      @showcase = Showcase.find_by(slug: params[:id])
    end

    def find_showcase_by_showcase_id
      @showcase = Showcase.find_by(slug: params[:showcase_id])
    end

    def find_all_showcases
      @showcases = Showcase.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    end
end
