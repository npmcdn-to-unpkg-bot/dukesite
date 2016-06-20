class Admin::CategoriesController < AdminController
  before_action :find_category, only: [:edit, :update, :destroy, :visible_switch]
  before_action :find_category_by_category_id, only: [:product_list, :update_image]
  before_action :find_all_categories, only: [:index, :create]
  
  def index
    @category = Category.new
    @category.photo = Photo.new
    @thumb_img_url = @category.thumb_img_url 
  end

  def product_list
    if @category.photo.present?
      @thumb_img_url = @category.thumb_img_url 
    else
      @category.photo = Photo.new
    end
    # Here, we must use paginate method to create @products,
    # so the front end can get data for the pagination.
    @keywords = @category.keywords.where.not(value: nil).order("created_at DESC")
    @products = @category.products.paginate(:page => params[:page], :per_page => 20)
  end

  def create
    # Don't create photo if no image is uploaded.
    if !params[:category][:photo_attributes].nil?
      @category = Category.new(category_params(:update_photo => true))
    else
      @category = Category.new(category_params)
    end
    if @category.save
      flash[:success] = "A new category was succefully created."
      redirect_to admin_categories_path
    else
      flash[:danger] = "Please try again."
      @category.photo = Photo.new
      @thumb_img_url = @category.thumb_img_url 
      render :index
    end 
  end

  def update
    # Don't update photo attributes if no image is uploaded.
    if !params[:category][:photo_attributes][:image].nil?
      if @category.update(category_params(:update_photo => true))
        flash[:success] = "Succefully updated."
        redirect_to admin_category_products_path(@category)
      else
        flash[:danger] = "Please try again."
        render :edit
      end
    elsif @category.update(category_params)
      flash[:success] = "A new category was succefully updated."
      redirect_to admin_category_products_path(@category)
    else
      flash[:danger] = "Please try again."
      render :index
    end
  end

  def visible_switch
    status = 200
    response = ""
    if @category.update_attribute(:visible, params[:visible])
      cat_status = @category.visible.to_s
    else
      status = 404
      response = "Please try again"
    end
    render json: { response: response, cat_status: cat_status },
           status: status
  end

  def update_image
    if params[:category].present? && @category.photo.update(photo_params)
      flash[:success] = "A new image was succefully uploaded."
      redirect_to admin_category_products_path(@category)
    else
      flash[:danger] = "Please try again."
      render :product_list
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "A new category was succefully deleted."
    redirect_to admin_categories_path
  end

  private
    def photo_params
      params.require(:category).permit(:image)
    end

    def category_params(options = {:update_photo => false})
      if options[:update_photo] 
        params.require(:category).permit(:name, :visible, photo_attributes: [:image])
      else
        params.require(:category).permit(:name, :visible)
      end
    end
    
    def find_category
      @category = Category.find_by(slug: params[:id])
    end

    def find_category_by_category_id
      @category = Category.find_by(slug: params[:category_id])
    end

    def find_all_categories
      @categories = Category.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    end
end
