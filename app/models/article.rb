class Article < ActiveRecord::Base
  scope :published, -> { where(published: true).order(published_at: :desc) }
  include SlugGenerator

  has_many :keywords, :as => :keywordable, dependent: :destroy
  has_one :photo, :as => :imageable, dependent: :destroy
  
  validates_presence_of :title

  accepts_nested_attributes_for :photo

  sluggable_column :title

  def self.recent_articles
    self.published.select(:id, :title, :subtitle, :slug)[0..9]
  end

  def previous_article
    self.class.where(["published_at < ?", self.published_at]).published.first
  end

  def next_article
    self.class.where(["published_at > ?", self.published_at]).published.last
  end

  def thumb_img_url
    self.photo.image.thumb.url if self.photo.present?
  end

  def img_url
    if self.photo.present? && !self.photo.image.url.nil?
      self.photo.image.url 
    end
  end
end
