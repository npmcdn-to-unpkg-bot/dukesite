class Admin::QuotesController < AdminController
  before_action :authenticate_admin!
  before_action :find_quote, only: [:edit]

  def index
    @quotes = Quote.all
    @quote = Quote.new
    @quote.photos.build
  end

  def create
    byebug
    @quote = Quote.new(params_quote)
    if @quote.save
      flash[:success] = "A new quote was succefully created."
      redirect_to admin_quotes_path
    else
      render :index
    end
  end

  private
    def find_quote
      @quote = Quote.find_by(slug: params[:id])
    end
    def params_quote
      params.require(:quote).permit(:title, :description, photos_attributes: [:image])
    end
end