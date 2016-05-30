class Photo < ActiveRecord::Base
  belongs_to :quote
  belongs_to :carousel
  belongs_to :site_config
  belongs_to :category
  belongs_to :showcase
  belongs_to :social_network_account 
  belongs_to :imageable, :polymorphic => true
  belongs_to :article

  mount_uploader :image, ImageUploader
end
