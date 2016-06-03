class Article < ActiveRecord::Base
  scope :published, -> { where(published: true) }
  include SlugGenerator

  has_many :keywords, :as => :keywordable, dependent: :destroy
  has_one :photo, :as => :imageable, dependent: :destroy
  
  validates_presence_of :title

  accepts_nested_attributes_for :photo

  sluggable_column :title

  def self.latest_articles
    self.where(:published => true).order("published_at DESC").where(:published => true).order("published_at DESC").select(:title, :slug)[0..9]
  end

  def previous_article
    self.class.where(["published_at < ?", self.published_at]).where(:published => true).order("published_at DESC").first
  end

  def next_article
    self.class.where(["published_at > ?", self.published_at]).where(:published => true).order("published_at DESC").last
  end

  def thumb_img_url(options = { :icon => false  })
    if self.photo.present?
      self.photo.image.thumb.url 
    elsif !options[:icon]
      return "http://thedudeminds.de/images/no_image_available.png"
    else
      icon = SiteConfig.find_by(slug: "icon").photo.image.url if SiteConfig.find_by(slug: "icon").present?
      if icon.present?
        return icon
      else
        return "http://thedudeminds.de/images/thedukegirls.png"
      end
    end
  end

  def img_url
    if self.photo.present? && !self.photo.image.url.nil?
      self.photo.image.url 
    else
      icon = SiteConfig.find_by(slug: "icon").photo.image.url if SiteConfig.find_by(slug: "icon").present?
      if icon.present?
        return icon
      else
        return "http://thedudeminds.de/images/thedukegirls.png"
      end
    end
  end
end
