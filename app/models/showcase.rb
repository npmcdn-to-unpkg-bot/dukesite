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

  def thumb_img_url(options = {:show_no_image_available => true})
    if self.photo.nil? || self.photo.image.thumb.url.nil? 
      if options[:show_no_image_available]
        return "http://thedudeminds.de/images/no_image_available.png"
      else
        nil
      end
    else
      self.photo.image.thumb.url
    end
  end
  def last_update
    self.updated_at.nil? ? time = self.updated_at : time = self.created_at
    return time.to_formatted_s(:db)
  end
end
