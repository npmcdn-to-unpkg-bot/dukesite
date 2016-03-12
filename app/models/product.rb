class Product < ActiveRecord::Base
  include SlugGenerator

  validates_presence_of :title, :url, :image_url
  
  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :product_showcases
  has_many :showcases, through: :product_showcases

  sluggable_column :title
end