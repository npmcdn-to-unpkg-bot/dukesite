class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :get_all_category, :get_visible_showcase
  protect_from_forgery with: :exception

  def get_all_category
    @categories = Category.all.where(:visible => true)
  end

  def get_visible_showcase
    @showcases = Showcase.all.where(:show_on_landing_page => true)
  end

  def create_subscriber
    response = ""
    status   = 200
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
