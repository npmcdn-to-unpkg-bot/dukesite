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
    look_up_item_on_amazon

    @product_details["Title"] = @product.title unless @product.title.nil?
    @product_details["Description"] = @product.description unless @product.description.nil?
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

  private
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :url, :published, :category_ids => [], :showcase_ids => [])
    end

    def find_product
      @product = Product.find_by(slug: params[:id])
    end

    def look_up_item_on_amazon
      require 'amazon/ecs'

      Amazon::Ecs.configure do |options|
        options[:AWS_access_key_id] = ENV["AWS_ACCESS_KEY_ID"]
        options[:AWS_secret_key] = ENV["AWS_SECRET_ACCESS_KEY"]
        options[:associate_tag] = ENV["ASSOCIATE_TAG"]
      end

      res = Amazon::Ecs.item_lookup(@product.asin, {:response_group => 'Medium'})
      item = res.get_element("Item")
      item_attributes = item.get_element('ItemAttributes')
      price = item_attributes.get("ListPrice/FormattedPrice")
      price_list = item_attributes.get("ListPrice")
      item_img = item.get_hash('LargeImage')
      item_ed_reviews = item.get_element("EditorialReview")

      @product_details = {
        "DetailPageURL"  => item_attributes.get('DetailPageURL'),
        "LargeImageURL"  => item_img["URL"],
        "Price"          => "",
        "Title"          => item_attributes.get("Title"),
        "Description"    => item_ed_reviews.get('Content')
      }

      @product_details["Price"] = price unless price_list == nil
    end
end
