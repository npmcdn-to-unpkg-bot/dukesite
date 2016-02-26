class Admin::ShowcasesController < AdminController
  layout "application", only: [:show]
  before_action :authenticate_admin!, except: [:show]
  before_action :find_showcase, only: [:show, :edit, :update, :destroy]
  def index
    @showcases = Showcase.all.order("updated_at DESC")
  end

  def show
  end

  def new
    @showcase = Showcase.new
  end

  def create
    @showcase = Showcase.new(showcase_params)
    if @showcase.save
      flash[:success] = "The showcase was successfully created."
      redirect_to admin_showcases_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @showcase.update(showcase_params)
      flash[:success] = "The showcase was successfully edited."
      redirect_to admin_showcases_path
    else
      render :edit
    end
  end

  def destroy
    @showcase.destroy
    flash[:success] = "The showcase was successfully deleted."
    redirect_to admin_showcases_path
  end

  private
    def showcase_params
      params.require(:showcase).permit(:title, :feature_img_url, :show_on_landing_page)
    end

    def find_showcase
      @showcase = Showcase.find(params[:id])
    end
end
