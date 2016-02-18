class Showcase < ActiveRecord::Base
  validates_presence_of :title, :feature_img
  has_many :products
end
