class Admin::SocialNetworkAccountsController < AdminController
  before_action :find_sna, only: [:edit, :update, :destroy]
  def index
    @all_snas = SocialNetworkAccount.all
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

  def destroy
    @sna.destroy
    flash[:success] = "A new category was succefully deleted."
    redirect_to admin_social_network_accounts_path
  end

  private
    def sna_params
      params.require(:social_network_account).permit(:platform_name, :platform_url, :visible, photo_attributes: [:image])
    end

    def find_sna
      @sna = SocialNetworkAccount.find_by(slug: params[:id])
    end
end
