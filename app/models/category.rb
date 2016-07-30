class Category < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
  
  include SlugGenerator
  validates_presence_of :name

  has_many :product_categories
  has_many :products, through: :product_categories
  
  has_many :keywords, :as => :keywordable, dependent: :destroy
  has_one :photo, :as => :imageable, dependent: :destroy

  accepts_nested_attributes_for :photo
  sluggable_column :name

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

  def published_products_desc
    self.products.where(published: true).order("updated_at DESC")
  end

  def valid_keywords
    self.keywords.where.not(value: nil).order("updated_at DESC").map(&:value) if self.keywords.present?
  end
  
  def last_update
    self.updated_at.nil? ? time = self.updated_at : time = self.created_at
    return time.to_formatted_s(:long)
  end
end
