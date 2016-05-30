class Article < ActiveRecord::Base
  scope :published, -> { where(published: true) }
  include SlugGenerator

  belongs_to :admin

  has_many :keywords, :as => :keywordable, dependent: :destroy
  has_one :photo, :as => :imageable, dependent: :destroy
  
  validates_presence_of :title

  accepts_nested_attributes_for :photo

  sluggable_column :title
end
