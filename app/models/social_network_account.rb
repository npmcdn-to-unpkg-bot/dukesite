class SocialNetworkAccount < ActiveRecord::Base
  include SlugGenerator
  validates_presence_of :platform_name, :platform_url, :image
  
  mount_uploader :image, ImageUploader
  sluggable_column :platform_name
end
