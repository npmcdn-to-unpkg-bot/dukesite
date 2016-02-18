class Admin::ShowcasesController < AdminController
  before_action :find_showcase, only: [:edit, :update, :delete]
  def index
    @showcases = Showcase.all.order("updated_at DESC")
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

  def delete
    @showcase = Showcase.find(params[:id])
    @showcase.destroy
    flash[:success] = "The showcase was successfully deleted."
    redirect_to admin_showcases_path
  end

  private
    def showcase_params
      params.require(:showcase).permit(:title, :feature_img_url)
    end

    def find_showcase
      @showcase = Showcase.find(params[:id])
    end
end
