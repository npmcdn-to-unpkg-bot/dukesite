class Admin::QuotesController < AdminController
  before_action :find_quote, only: [:edit, :show, :update, :destroy]
  before_action :find_all_quotes, only: [:index, :create]
  def index
    @quote = Quote.new
    @quote.photos.build
  end

  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      flash[:success] = "A new quote was succefully created."
      redirect_to admin_quotes_path
    else
      render :index
    end
  end

  def show
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      flash[:success] = "successfully edited."
      redirect_to admin_quotes_path
    else
      render :edit
    end
  end

  def visible_switch
    status = 200
    response = ""
    if @quote.update_attribute(:visible, params[:visible])
      flash[:success] = "Successfully updated."
      quote = @quote.visible
    else
      status = 404
      response = "Please try again"
    end
    render json: { response: response, quote_status: quote_status },
           status: status
  end

  def destroy
    @quote.destroy
    flash[:success] = "The quote was successfully deleted."
    redirect_to admin_quotes_path
  end

  private
    def find_quote
      @quote = Quote.find_by(slug: params[:id])
    end
    def quote_params
      params.require(:quote).permit(:title, :description, photos_attributes: [:image])
    end

    def find_all_quotes
      @quotes = Quote.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    end
end