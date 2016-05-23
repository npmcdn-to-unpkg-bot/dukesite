class SubscribersController < ApplicationController

  def create
    status   = 200
    response = ""
    if params[:email].blank?
      status   = 400
      response = "Please enter email address."
    else
      subscriber = Subscriber.create(email: params[:email])
      UserMailer.notify_subscription(subscriber).deliver_later
      response = "You've subscirbed Newsletter from The Duke Girls."
    end
    render json: {response: response},
           status: status
  end

  def confirm_email
    subscriber = Subscriber.find_by_confirm_token(params[:id])
    if subscriber.present?
      subscriber.update_attributes(:confirm_token => nil, :confirmed=> true)
      UserMailer.confirm_subscription(subscriber).deliver_later
      @message =  "Your Newsletter subscription is confirmed."
    else
      @message =  "Sorry. Subscriber does not exist."
      redirect_to root_path
    end
  end

end