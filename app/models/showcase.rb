class Showcase < ActiveRecord::Base
  validates_presence_of :title, :feature_img_url
  has_many :products
end
