class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!
  before_action :get_all_showcase, :get_all_category
  def index
    @subscriber_num = Subscriber.select(:email).uniq.length
  end

  def get_all_showcase
    @showcases = Showcase.all
  end

  def get_all_category
    @categories = Category.all
  end
end