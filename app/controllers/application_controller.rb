class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :get_visible_category, :get_landing_page_showcase, :get_social_network_account
  protect_from_forgery with: :exception

  def get_visible_category
    @categories = Category.where(:visible => true)
  end

  def get_landing_page_showcase
    @showcases = Showcase.where({:visible => true, :show_on_landing_page => true})
  end
  def get_social_network_account
    @social_network_accounts = SocialNetworkAccount.all
  end

  def create_subscriber
    status   = 200
    response = ""
    if params[:email].blank?
      status   = 400
      response = "Please enter email address."
    else
      @subscriber = Subscriber.create(email: params[:email])
      response = "You've subscirbed Newsletter from Duke for Girls."
    end
    render json: {response: response},
           status: status
  end
end
