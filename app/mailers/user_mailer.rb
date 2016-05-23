class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def notify_subscription(subscriber)
    @email = subscriber.email
    @token = subscriber.confirm_token
    mail :to=> subscriber.email, :subject => "Confirm Your Subscription"
  end

  def confirm_subscription(subscriber)
    @email = subscriber.email
    mail :to=> subscriber.email, :subject => "Newsletter Subscribed"
  end

  def send_newsletter(receiver_email, subject, content)
    @content = content
    mail :to=> receiver_email, :subject => subject
  end
end
