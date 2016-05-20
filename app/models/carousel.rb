class Carousel < ActiveRecord::Base
  include SlugGenerator
  validates_presence_of :title
  has_one :photo, :as => :imageable, dependent: :destroy
  
  accepts_nested_attributes_for :photo
  sluggable_column :title
end