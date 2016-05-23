class Subscriber < ActiveRecord::Base
  before_create :generate_confirm_token

  validates_presence_of :email

  private
    def generate_confirm_token
      self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.blank?
    end
end