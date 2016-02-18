class Product < ActiveRecord::Base
  validates_presence_of :title, :url
  belongs_to :showcase
end
