class Image < ActiveRecord::Base
  include SlugGenerator

  validates_presence_of :title, :url

  sluggable_column :title
end
