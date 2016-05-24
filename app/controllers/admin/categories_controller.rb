class Admin::CategoriesController < AdminController
  before_action :find_category, only: [:product_list, :edit, :update, :destroy, :visible_switch]
  before_action :find_all_categories, only: [:index, :create]
  def index
    @category = Category.new
  end

  def product_list
    # Here, we must use paginate method to create @products,
    # so the front end can get data for the pagination.
    @keywords = @category.keywords.where.not(value: nil).order("created_at DESC")
    @products = @category.products.paginate(:page => params[:page], :per_page => 20)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "A new category was succefully created."
      redirect_to :back
    else
      render :index
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = "successfully edited."
      redirect_to :back
    else
      render :edit
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

  def destroy
    @category.destroy
    flash[:success] = "A new category was succefully deleted."
    redirect_to admin_categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :visible, :image)
    end
    
    def find_category
      @category = Category.find_by(slug: params[:id])
    end
    def find_all_categories
      @categories = Category.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    end
end
