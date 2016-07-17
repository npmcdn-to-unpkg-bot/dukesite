class Admin::SocialNetworkAccountsController < AdminController
  before_action :find_sna, only: [:edit, :update, :destroy]
  before_action :find_sna_by_sna_id, only: [:update_image]
  def index
    @accounts = SocialNetworkAccount.all
    @sna = SocialNetworkAccount.new
    @sna.photo = Photo.new
  end

  def new
    @sna = SocialNetworkAccount.new
  end

  def edit
  end
  def create
    @sna = SocialNetworkAccount.new(sna_params)
    if @sna.save
      flash[:success] = "A new account was succefully created."
      redirect_to admin_social_network_accounts_path
    else
      render :index
    end
  end
  def update
    if @sna.update(sna_params)
      flash[:success] = "Succefully updated."
      redirect_to admin_social_network_accounts_path
    else
      status = 200
      @all_snas = SocialNetworkAccount.all
      render :index, json: { response: response },
             status: status
    end
  end

  def update_image
    if params[:social_network_account].present? && @sna.photo.update(photo_params)
      flash[:success] = "A new image was succefully uploaded."
      redirect_to admin_social_network_accounts_path
    else
      flash[:danger] = "Please try again."
      render :index
    end
  end

  def destroy
    @sna.destroy
    flash[:success] = "A new category was succefully deleted."
    redirect_to admin_social_network_accounts_path
  end

  private
    def photo_params
      params.require(:social_network_account_id).permit(:image)
    end

    def sna_params
      params.require(:social_network_account).permit(:platform_name, :platform_url, :visible, photo_attributes: [:image])
    end

    def find_sna
      @sna = SocialNetworkAccount.find_by(slug: params[:id])
    end

    def find_sna_by_sna_id
      @sna = SocialNetworkAccount.find_by(slug: params[:social_network_account_id])
    end
end
