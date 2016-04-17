class Admin::ProductsController < AdminController
  layout "application", only: [:show]
  before_action :authenticate_admin!, except: [:show]
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

    if @product.save
      flash[:success] = "A product was successfully created."
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def show
    lookup_price_on_amazon
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
      response = "Please enter ASIN."
    else

      request_amazon('Variations', params[:asin]) #Check if the ASIN is a parent ASIN
      if @res.has_error?
        status   = 400
        response = params[:asin] + " cannot be found. Please check the ASIN."
      else
        @product_details = []
        asins = ""
        @res.items[0..9].each do |item| # only use the first 10 ASINS
          asin = item.get('ASIN')
          asins << asin + ',' # Use ',' and no space " "
        end
        asins = asins.slice(0..-2) # get rid of the "," at the end of the asins string
        request_amazon('Medium', asins) # Performing Multiple ItemLookups in One Request (only upto 10 ASINS are allowed)
        response = "Item found."

        @res.items.each do |item|
          asin = item.get('ASIN')
          detail_page_url = item.get("DetailPageURL") #get the url to amazon detail page
          title = item.get('ItemAttributes/Title') #get title
          item_img = item.get_hash('LargeImage') #get large image url
          editorial_review = item.get_element('EditorialReview') # get description
          description = editorial_review.get('Content') # get description

          product_detail = {
            "asin"           => asin,
            "title"          => title,
            "detail_page_url"  => detail_page_url,
            "large_image_url"  => item_img["URL"],
            "description"    => description
          }
          product_detail = OpenStruct.new(product_detail)
          @product_details << product_detail
        end
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

    def lookup_price_on_amazon
      request_amazon('ItemAttributes', @product.asin)
      price_list = @res.get_element("ListPrice")
      if price_list.present?
        @price = price_list.get("FormattedPrice")
      else
        @price = "---"
      end
    end

    def request_amazon(response_group, asin)
      require 'amazon/ecs'

      Amazon::Ecs.configure do |options|
        options[:AWS_access_key_id] = ENV["AWS_ACCESS_KEY_ID"]
        options[:AWS_secret_key] = ENV["AWS_SECRET_ACCESS_KEY"]
        options[:associate_tag] = ENV["ASSOCIATE_TAG"]
      end
      @res = Amazon::Ecs.item_lookup(asin, {:response_group => response_group})
    end

end
