class Admin::ShowcasesController < AdminController
  before_action :find_showcase, only: [:product_list, :edit, :update, :destroy, :visible_switch]
  before_action :find_all_showcases, only: [:index, :create]
  def index
    @showcase = Showcase.new
  end

  def product_list
    # Here, we must use paginate method to create @products,
    # so the front end can get data for the pagination.
    @keywords = @showcase.keywords.where.not(value: nil).order("created_at DESC")
    @products = @showcase.products.paginate(:page => params[:page], :per_page => 20)
  end

  def create
    @showcase = Showcase.new(showcase_params)
    if @showcase.save
      flash[:success] = "The showcase was successfully created."
      redirect_to admin_showcases_path
    else
      render :index
    end
  end

  def edit
  end

  def update
    if @showcase.update(showcase_params)
      flash[:success] = "successfully edited."
      redirect_to admin_showcase_products_path(@showcase)
    else
      render :edit
    end
  end

  def visible_switch
    status = 200
    response = ""
    if @showcase.update_attribute(:visible, params[:visible])
      flash[:success] = "Successfully updated."
      showcase_status = @showcase.visible
    else
      status = 404
      response = "Please try again"
    end
    render json: { response: response, showcase_status: showcase_status },
           status: status
  end

  def destroy
    @showcase.destroy
    flash[:success] = "The showcase was successfully deleted."
    redirect_to admin_showcases_path
  end

  private
    def showcase_params
      params.require(:showcase).permit(:title, :show_on_landing_page, :visible, :image)
    end

    def find_showcase
      @showcase = Showcase.find_by(slug: params[:id])
    end

    def find_all_showcases
      @showcases = Showcase.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    end
end
