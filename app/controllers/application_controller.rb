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
    @subscriber = Subscriber.create(email: params[:email])
    render json: 'ok'.to_json
  end
end
