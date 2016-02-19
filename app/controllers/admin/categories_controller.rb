class Admin::CategoriesController < AdminController
  before_action :authenticate_admin!
  before_action :find_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.all
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
