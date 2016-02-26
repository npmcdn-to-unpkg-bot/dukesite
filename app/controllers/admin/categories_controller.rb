class Admin::CategoriesController < AdminController
  layout "application", only: [:show]
  before_action :authenticate_admin!, except: [:show]
  before_action :find_category, only: [:show, :product_list, :edit, :update, :destroy]
  def index
  end

  def show
  end

  def product_list
    @products = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "A new category was succefully created."
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "A new category was succefully edited."
      redirect_to admin_categories_path
    else
      render :edit
    end 
  end

  def destroy
    @category.destroy
    flash[:success] = "A new category was succefully deleted."
    redirect_to admin_categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
    def find_category
      @category = Category.find(params[:id])
    end
end
