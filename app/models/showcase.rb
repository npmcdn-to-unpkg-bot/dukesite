class Showcase < ActiveRecord::Base
  include SlugGenerator
  validates_presence_of :title, :feature_img_url

  has_many :product_showcases
  has_many :products, through: :product_showcases

  sluggable_column :title
end
