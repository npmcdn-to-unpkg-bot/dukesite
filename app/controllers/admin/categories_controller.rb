class Admin::CategoriesController < AdminController
  before_action :find_category, only: [:product_list, :edit, :update, :destroy]
  def index
    @category = Category.new
  end

  def product_list
    @products = @category.products
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "A new category was succefully created."
      redirect_to admin_categories_path
    else
      render :index
    end
  end

  def update
    status = 200
    response = ""
    if @category.update(category_params)
      response = "Successfully updated."
      cat_status = @category.visible
      cat_name = @category.name
      cat_img_url = @category.img_url
    else
      status = 404
      response = "Please try again"
    end
    render json: { response: response, cat_status: cat_status, cat_name: cat_name, cat_img_url: cat_img_url },
           status: status
  end

  def destroy
    @category.destroy
    flash[:success] = "A new category was succefully deleted."
    redirect_to admin_categories_path
  end

  private
    def category_params
      params.require(:category).permit(:name, :visible, :img_url)
    end
    
    def find_category
      @category = Category.find_by(slug: params[:id])
    end
end
