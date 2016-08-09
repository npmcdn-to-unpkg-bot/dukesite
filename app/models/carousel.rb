class Carousel < ActiveRecord::Base
  default_scope { order(updated_at: :desc) }
  scope :visible, -> { where(visible: true) }

  include SlugGenerator
  validates_presence_of :title
  has_one :photo, :as => :imageable, dependent: :destroy
  
  accepts_nested_attributes_for :photo
  sluggable_column :title

  def thumb_img_url
    if self.photo.image.present? && !self.photo.image.thumb.url.nil?
      self.photo.image.thumb.url
    else
      return "http://thedudeminds.de/images/no_image_available.png"
    end
  end

  def self.visible_carousel_img_urls
    self.visible.map(&:photo).compact.map(&:image).map(&:url) if self.visible.present?
  end
  
  def last_update
    self.updated_at.nil? ? time = self.updated_at : time = self.created_at
    return time.to_formatted_s(:long)
  end
end
