class Article < ActiveRecord::Base
  scope :published, -> { where(published: true) }
  include SlugGenerator

  belongs_to :admin

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
end
