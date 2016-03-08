class Category < ActiveRecord::Base
  include SlugGenerator

  has_many :product_categories
  has_many :products, through: :product_categories

  sluggable_column :name
end
