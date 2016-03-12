class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!
  def index
    @subscriber_num = Subscriber.select(:email).uniq.length
  end
end