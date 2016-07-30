class Quote < ActiveRecord::Base
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

  def last_update
    self.updated_at.nil? ? time = self.updated_at : time = self.created_at
    return time.to_formatted_s(:long)
  end
end
