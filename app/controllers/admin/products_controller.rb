class Admin::ProductsController < AdminController
  layout "application", only: [:show]
  before_action :authenticate_admin!, except: [:show]
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.order("updated_at DESC")
  end

  def new
    @product = Product.new
    @categories = Category.all
    @showcases = Showcase.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "A product was successfully created."
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    @categories = Category.all
    @showcases = Showcase.all
  end

  def update
    if @product.update(product_params)
      flash[:success] = "A product was successfully edited."
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "A product was successfully deleted."
    redirect_to admin_products_path
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :url, :showcase_ids => [])
    end
    def find_product
      @product = Product.find(params[:id])
    end
end
