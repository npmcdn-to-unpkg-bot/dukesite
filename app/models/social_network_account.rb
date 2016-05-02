class SocialNetworkAccount < ActiveRecord::Base

  mount_uploader :image, ImageUploader
end
