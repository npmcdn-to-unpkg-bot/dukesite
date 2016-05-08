class Admin::ProductsController < AdminController
  before_action :find_product, only: [:edit, :update, :destroy, :publish_switch]

  def index
    @products = Product.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @product = Product.new
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

  def edit
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

  def publish_switch
    status = 200
    response = ""
    if @product.update(product_params)
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
      asin_param = params[:asin].squish()
      res = Product.lookup_items_on_amazon('Medium', asin_param)
      if res.error.present?
        status   = 400
        response = asin_param + " cannot be found on Amazon server. Please check the ASIN."
      else
        returned_items = res.product_details
        response = returned_items.size.to_s + " item(s) are found."
        @product_details = returned_items
      end
    end
    render json: {response: response, 
                  data: @product_details},
           status: status
  end

  private
    def product_params
      params.require(:product).permit(:asin, :title, :description, :image_url, :url, :published, :category_ids => [], :showcase_ids => [])
    end

    def find_product
      @product = Product.find_by(slug: params[:id])
    end
end
