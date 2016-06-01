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

  def thumb_img_url
    if self.photo.image.thumb.url.nil?
      return "http://thedudeminds.de/images/no_image_available.png"
    else
      return self.photo.image.thumb.url
    end
  end
end
