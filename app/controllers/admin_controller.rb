class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!
  def index
    subscriber_emails = Subscriber.select(:email).uniq
    @subscriber_num = subscriber_emails.size
  end
end