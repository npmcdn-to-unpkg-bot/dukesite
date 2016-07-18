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

  def self.get_value(key)
    self.find_by(slug: key).value if self.find_by(slug: key).present?
  end

  def self.get_img_url(key)
    self.find_by(slug: key).img_url if self.find_by(slug: key).present?
  end

  def self.default_keywords
    self.find_by(slug: "seo").keywords.where.not(value: nil).order("created_at DESC").map(&:value) if self.find_by(slug: "seo").present?
  end

  def last_update
    self.updated_at.nil? ? time = self.updated_at : time = self.created_at
    return time.to_formatted_s(:long)
  end
end