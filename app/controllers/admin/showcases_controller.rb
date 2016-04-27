class Admin::ShowcasesController < AdminController
  before_action :find_showcase, only: [:product_list, :edit, :update, :destroy, :visible_switch]
  def index
    @showcases = Showcase.all.order("updated_at DESC").paginate(:page => params[:page], :per_page => 20)
    @showcase = Showcase.new
  end

  def product_list
    # Here, we must use paginate method for the @products,
    # so the front end can get data for the pagination.
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
      redirect_to admin_showcases_path
    else
      render :edit
    end
  end

  def visible_switch
    status = 200
    response = ""
    if @showcase.update(showcase_params)
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
      params.require(:showcase).permit(:title, :feature_img_url, :show_on_landing_page, :visible)
    end

    def find_showcase
      @showcase = Showcase.find_by(slug: params[:id])
    end
end
