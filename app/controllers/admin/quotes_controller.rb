class Admin::QuotesController < AdminController
  before_action :find_quote, only: [:edit, :update, :destroy, :visible_switch]
  before_action :find_quote_by_quote_id, only: [:update_image]
  before_action :find_all_quotes, only: [:index, :create]

  def index
    @quote = Quote.new
    @quote.photo = Photo.new
    @thumb_img_url = @quote.thumb_img_url
  end

  def create
    # Don't create photo if no image is uploaded.
    if !params[:quote][:photo_attributes].nil?
      @quote = Quote.new(quote_params(:update_photo => true))
    else
      @quote = Quote.new(quote_params)
    end # Don't create photo if no image is uploaded.

    if @quote.save
      flash[:success] = "A quote was successfully created."
      redirect_to admin_quotes_path
    else
      @quote.photo = Photo.new
      @thumb_img_url = @quote.thumb_img_url
      render :index
    end
  end

  def edit
    if @quote.photo.nil?
      @quote.photo = Photo.new
    else
      @thumb_img_url = @quote.thumb_img_url
    end
  end

  def update
    # Don't update photo attributes if no image is uploaded.
    if !params[:quote][:photo_attributes].nil?
      if @quote.update(quote_params(:update_photo => true))
        flash[:success] = "Successfully updated."
        redirect_to admin_quotes_path
      else
        flash[:danger] = "Please try again."
        render :edit
      end
    elsif @quote.update(quote_params)
      flash[:success] = "Successfully updated."
      redirect_to admin_quotes_path
    else
      flash[:danger] = "Please try again."
      render :edit
    end
  end

  def visible_switch
    status = 200
    response = ""
    if @quote.update_attribute(:visible, params[:visible])
      flash[:success] = "Successfully updated."
      quote_status = @quote.visible
    else
      status = 404
      response = "Please try again"
    end
    render json: { response: response, quote_status: quote_status },
           status: status
  end

  def update_image
    if params[:quote].present? && @quote.photo.update(photo_params)
      flash[:success] = "A new image was succefully uploaded."
      redirect_to edit_admin_quote_path(@quote)
    else
      flash[:danger] = "Please try again."
      render :edit
    end
  end

  def destroy
    @quote.destroy
    flash[:success] = "The quote was successfully deleted."
    redirect_to admin_quotes_path
  end

  private
    def photo_params
      params.require(:quote).permit(:image)
    end

    def find_quote
      @quote = Quote.find_by(slug: params[:id])
    end

    def find_quote_by_quote_id
      @quote = Quote.find_by(slug: params[:quote_id])
    end

    def quote_params(options = {:update_photo => false})
      if options[:update_photo]
        params.require(:quote).permit(:title, :description, photo_attributes: [:image])
      else
        params.require(:quote).permit(:title, :description)
      end
    end

    def find_all_quotes
      @quotes = Quote.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    end
end