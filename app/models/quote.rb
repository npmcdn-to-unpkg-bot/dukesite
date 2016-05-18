class Quote < ActiveRecord::Base
  include SlugGenerator
  validates_presence_of :title
  has_many :photos, :as => :imageable, dependent: :destroy

  accepts_nested_attributes_for :photos
  sluggable_column :title
end
