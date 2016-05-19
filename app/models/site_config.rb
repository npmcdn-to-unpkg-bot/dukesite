class SiteConfig< ActiveRecord::Base
  scope :web_settings, -> { where(slug: ['title', 'description', 'our-belief']) }
  scope :icons, -> { where(slug: ['favorite-icon', 'icon']) }
  include SlugGenerator

  validates_uniqueness_of :key
  has_one :photo, :as => :imageable, dependent: :destroy
  has_many :keywords, :as => :keywordable, dependent: :destroy

  accepts_nested_attributes_for :photo
  sluggable_column :key
end