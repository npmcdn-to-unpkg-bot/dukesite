# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/notify_subscription
  def notify_subscription
    UserMailer.notify_subscription
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/confirm_subscription
  def confirm_subscription
    UserMailer.confirm_subscription
  end

end
