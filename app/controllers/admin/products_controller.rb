class Admin::ProductsController < AdminController
  before_action :find_product, only: [:edit, :update, :destroy, :publish_switch]

  def index
    @products = Product.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @product = Product.new
    @all_showcases = Showcase.all
    @all_categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "A product was successfully created."
      redirect_to admin_products_path
    else
      @all_showcases = Showcase.all
      @all_categories = Category.all
      render :new
    end
  end

  def edit
    @all_categories = Category.all
    @all_showcases = Showcase.all
    @keywords = @product.keywords
  end

  def update
    if @product.update(product_params)
      flash[:success] = "A product was successfully edited."
      redirect_to admin_products_path
    else
      @all_showcases = Showcase.all
      @all_categories = Category.all
      render :edit
    end
  end

  def publish_switch
    status = 200
    response = ""
    if @product.update_attribute(:published, params[:published])
      flash[:success] = "Successfully updated."
      product_status = @product.published
    else
      status = 404
      response = "Please try again"
    end
    render json: { response: response, product_status: product_status },
           status: status
  end

  def destroy
    @product.destroy
    flash[:success] = "A product was successfully deleted."
    redirect_to admin_products_path
  end

  def lookup_item_on_amazon
    response = ""
    status   = 200
    if params[:asin].blank?
      status   = 400
      response = "Please enter ASIN"
    else
      asin = params[:asin].strip
      res = Amazon::EcsWrapper.get_item_group(asin)
      if res.respond_to? ('error')
        status   = 400
        response = res.error
      else
        response = res.length.to_s + " item(s) are found."
        @product_details = res
      end
    end
    render json: {response: response,
                  data: @product_details},
           status: status
  end

  def update_imgs
    @products = Product.all
    esponse = ""
    if Amazon::EcsWrapper.update_imgs(@products)
      status = 200
    else
      status = 400
      response = "Please try again."
    end
    render json: { response: response }, status: status
  end

  private
    def product_params
      params.require(:product).permit(:asin, :title, :description, :image_url, :image_url_small, :url, :published, :category_ids => [], :showcase_ids => [])
    end

    def find_product
      @product = Product.find_by(slug: params[:id])
    end
end
