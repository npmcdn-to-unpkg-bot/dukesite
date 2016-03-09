class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :get_category, :get_showcase
  protect_from_forgery with: :exception
  def get_category
    @categories = Category.all
  end
  def get_showcase
    @showcases = Showcase.all
  end

  def create_subscriber
    response = ""
    status   = 200
    if params[:email].blank?
      response = "Please enter email address."
    else
      @subscriber = Subscriber.create(email: params[:email])
      response = "You've subscirbed Newsletter from Duke for Girls."
    end
    render json: {response: response},
           status: status
  end
end
