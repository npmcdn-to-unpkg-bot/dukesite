class Quote < ActiveRecord::Base
  has_many :photos, :as => :imageable, dependent: :destroy
  validates_presence_of :title

  accepts_nested_attributes_for :photos
end
