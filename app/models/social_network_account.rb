class SocialNetworkAccount < ActiveRecord::Base
  include SlugGenerator
  validates_presence_of :platform_name, :platform_url, :image
  validates_uniqueness_of :platform_name, :platform_url
  
  mount_uploader :image, ImageUploader
  sluggable_column :platform_name
end
