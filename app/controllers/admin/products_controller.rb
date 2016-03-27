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
    look_up_price_from_amazon
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

  def look_up_item_from_amazon
    request_amazon('Medium')

    item = @res.get_element("Item")
    item_attributes = item.get_element('ItemAttributes')
    item_img = item.get_hash('LargeImage')
    item_ed_reviews = item.get_element("EditorialReview")

    @product_details = {
      "Title"          => item_attributes.get("Title"),
      "DetailPageURL"  => item_attributes.get('DetailPageURL'),
      "LargeImageURL"  => item_img["URL"],
      "Description"    => item_ed_reviews.get('Content')
    }
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :url, :published, :category_ids => [], :showcase_ids => [])
    end

    def find_product
      @product = Product.find_by(slug: params[:id])
    end

    def look_up_price_from_amazon
      request_amazon('ItemAttributes')
      price_list = @res.get_element("ListPrice")
      if price_list.present?
        @price = price_list.get("FormattedPrice")
      else
        @price = "---"
      end
    end

    def request_amazon(str)
      require 'amazon/ecs'

      Amazon::Ecs.configure do |options|
        options[:AWS_access_key_id] = ENV["AWS_ACCESS_KEY_ID"]
        options[:AWS_secret_key] = ENV["AWS_SECRET_ACCESS_KEY"]
        options[:associate_tag] = ENV["ASSOCIATE_TAG"]
      end
      @res = Amazon::Ecs.item_lookup(@product.asin, {:response_group => str})
    end
end
