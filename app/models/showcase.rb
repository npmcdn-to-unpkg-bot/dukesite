class Showcase < ActiveRecord::Base
  include SlugGenerator
  validates_presence_of :title

  has_many :product_showcases
  has_many :products, through: :product_showcases

  mount_uploader :image, ImageUploader
  sluggable_column :title
end
