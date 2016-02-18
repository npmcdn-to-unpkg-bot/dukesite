class Admin::ProductsController < AdminController
  layout "application", only: [:show]
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = Product.all.order("updated_at DESC")
  end

  def new
    @product = Product.new
    @showcases = Showcase.all
  end

  def create
    @product = Product.new(product_params)
    @showcases = Showcase.all
    if @product.save
      flash[:success] = "A product was created successfully."
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    @showcases = Showcase.all
  end

  def update
    if @product.update(product_params)
      flash[:success] = "A product was edited successfully."
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path
  end

  private
    def product_params
      params.require(:product).permit(:title, :url, :description, :showcase_id, :carousel)
    end
    def find_product
      @product = Product.find(params[:id])
    end
end
