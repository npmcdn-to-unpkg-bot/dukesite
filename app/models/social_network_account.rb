class SocialNetworkAccount < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
  
  include SlugGenerator
  validates_presence_of :platform_name, :platform_url

  has_one :photo, :as => :imageable, dependent: :destroy

  accepts_nested_attributes_for :photo
  sluggable_column :platform_name
end
