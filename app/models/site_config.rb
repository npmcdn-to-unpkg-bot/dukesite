class SiteConfig< ActiveRecord::Base
  scope :web_settings, -> { where(slug: ['title', 'description', 'our-belief']) }
  scope :site_intros, -> { where(slug: ['our-story', 'join-us']) }
  scope :icons, -> { where(slug: ['favorite-icon', 'icon']) }
  include SlugGenerator

  validates_uniqueness_of :key
  has_one :photo, :as => :imageable, dependent: :destroy
  has_many :keywords, :as => :keywordable, dependent: :destroy

  accepts_nested_attributes_for :photo
  sluggable_column :key

  def img_url
    if self.photo.present? && self.photo.image.url.present?
      self.photo.image.url 
    else
      return "http://thedudeminds.de/images/thedukegirls.png"
    end
  end

  def keywords_value
    self.keywords.map(&:value) if self.keywords.present?
  end
end