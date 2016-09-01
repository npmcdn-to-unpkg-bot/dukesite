class Showcase < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
  scope :visible_on_landing_page, -> { visible.where(show_on_landing_page: true) }
  include SlugGenerator
  validates_presence_of :title

  has_many :product_showcases
  has_many :products, through: :product_showcases
  
  has_many :keywords, :as => :keywordable, dependent: :destroy
  has_one :photo, :as => :imageable, dependent: :destroy

  accepts_nested_attributes_for :photo
  sluggable_column :title

  def published_products
    self.products.where(published: true).order("updated_at DESC")
  end

  def valid_keywords
    self.keywords.where.not(value: nil).order("updated_at DESC").map(&:value) if self.keywords.present?
  end

  def thumb_img_url
    if self.photo.present? && self.photo.image.thumb.url.present? 
      self.photo.image.thumb.url
    end
  end
end
