class Photo < ActiveRecord::Base
  belongs_to :quote
  belongs_to :imageable, :polymorphic => true

  mount_uploader :image, ImageUploader
end
