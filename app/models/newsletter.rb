class Newsletter < ActiveRecord::Base
  scope :sent, ->{where(sent: true)}
  scope :unsent, ->{where(sent: false)}

  validates_presence_of :subject

end
