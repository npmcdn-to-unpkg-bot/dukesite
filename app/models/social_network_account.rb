class SocialNetworkAccount < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
  
  include SlugGenerator
  validates_presence_of :platform_name, :platform_url, :image
  
  mount_uploader :image, ImageUploader
  sluggable_column :platform_name
end
