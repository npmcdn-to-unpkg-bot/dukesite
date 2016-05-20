class Category < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
  
  include SlugGenerator
  validates_presence_of :name

  has_many :product_categories
  has_many :products, through: :product_categories
  
  mount_uploader :image, ImageUploader
  
  sluggable_column :name
end
