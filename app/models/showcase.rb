class Showcase < ActiveRecord::Base
  validates_presence_of :title, :feature_img_url

  has_many :product_showcases
  has_many :products, through: :product_showcases
end
