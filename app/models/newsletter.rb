class Newsletter < ActiveRecord::Base
  default_scope { order(updated_at: :desc) }
  scope :sent, ->{where(sent: true)}
  scope :unsent, ->{where(sent: false)}

  validates_presence_of :subject
end
