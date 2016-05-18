class SiteConfig< ActiveRecord::Base
  scope :web_settings, -> { where(slug: ['title', 'description', 'our-belief']) }
  include SlugGenerator
  validates_uniqueness_of :key

  has_many :keywords, :as => :keywordable, dependent: :destroy
  sluggable_column :key
end