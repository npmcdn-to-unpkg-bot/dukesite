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
    request = Vacuum.new
    request.configure(
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      associate_tag: ENV["ASSOCIATE_TAG"]
    )
    response = request.item_lookup(
      query: {
        'ItemId': @product.asin,
        "ResponseGroup": "Medium"
      }
    )
    res_hash = response.to_h
    item = res_hash["ItemLookupResponse"]["Items"]["Item"]

    @product_details = {
      "DetailPageURL"  => item["DetailPageURL"],
      "SmallImageURL"  => item["SmallImage"]["URL"],
      "MediumImageURL" => item["MediumImage"]["URL"],
      "LargeImageURL"  => item["LargeImage"]["URL"],
      "Price"          => "",
      "Title"          => item["ItemAttributes"]["Title"],
      "Description"    => item["EditorialReviews"]["EditorialReview"]["Content"]
    }

    @product_details["Title"] = @product.title unless @product.title.nil?
    @product_details["Description"] = @product.description unless @product.description.nil?
    @product_details["Price"] = item["ItemAttributes"]["ListPrice"]["FormattedPrice"] unless item["ItemAttributes"]["ListPrice"] == nil
  
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
end
