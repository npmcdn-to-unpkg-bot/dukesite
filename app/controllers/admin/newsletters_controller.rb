class Admin::NewslettersController < AdminController
  before_action :find_newsletter, only: [:edit, :update, :destroy]
  def index
    @confirmed_subscriber = Subscriber.confirmed
    @unconfirmed_subscriber = Subscriber.unconfirmed

    @sent_newsletter = Newsletter.sent
    @unsent_newsletter = Newsletter.unsent
    @newsletters = Newsletter.all
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      flash[:success] = "A new newsletter was succefully created."
      redirect_to admin_newsletters_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @newsletter.update(newsletter_params)
      flash[:success] = "Succefully updated."
      redirect_to admin_newsletters_path
    else
      render :edit
    end
  end

  def destroy
    @newsletter.destroy
    flash[:success] = "The newsletter was successfully deleted."
    redirect_to admin_newsletters_path
  end

  def send_newsletter
    newsletter = Newsletter.find(params[:newsletter_id])
    subject = newsletter.subject
    content = newsletter.content
    receivers = Subscriber.confirmed
    receivers.each do |receiver|
      UserMailer.send_newsletter(receiver.email, subject, content).deliver_later
    end

    if newsletter.update_attributes(:sent => true, :sent_at=> Time.now)
      flash[:success] = "Succefully delivered."
      redirect_to admin_newsletters_path
    else
      flash[:error] = "Please try again."
      render :index
    end

  end

  private
    def find_newsletter
      @newsletter = Newsletter.find(params[:id])
    end
    def newsletter_params
      params.require(:newsletter).permit(:subject, :content, :sent, :sent_at)
    end
end