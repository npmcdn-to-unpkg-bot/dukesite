class Carousel < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }

  include SlugGenerator
  validates_presence_of :title
  has_one :photo, :as => :imageable, dependent: :destroy
  
  accepts_nested_attributes_for :photo
  sluggable_column :title

  def thumb_img_url
    if self.photo.image.thumb.url.nil?
      return "http://thedudeminds.de/images/no_image_available.png"
    else
      self.photo.image.thumb.url
    end
  end

  def self.visible_carousel_img_urls
    self.visible.map(&:photo).map(&:image).map(&:url)
  end
end