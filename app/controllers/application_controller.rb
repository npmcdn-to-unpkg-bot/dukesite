class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :get_category
  protect_from_forgery with: :exception
  def get_category
    @categories = Category.all
  end
end
