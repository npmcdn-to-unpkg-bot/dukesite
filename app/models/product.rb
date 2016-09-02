class Product < ActiveRecord::Base
  default_scope { order(updated_at: :desc) }
  include SlugGenerator

  validates_presence_of :title, :url, :image_url, :asin, :image_url_small
  validates_uniqueness_of :asin

  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :product_showcases
  has_many :showcases, through: :product_showcases

  has_many :keywords, :as => :keywordable, dependent: :destroy

  sluggable_column :title

  def visible_categories
    self.categories.where(visible: true)
  end

  def visible_showcases
    self.showcases.where(visible: true)
  end
  
  def valid_keywords
    self.keywords.map(&:value) if self.keywords.present?
  end

  def self.all_products_amount
    self.all.length
  end
end
