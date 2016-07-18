class SocialNetworkAccount < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
  
  include SlugGenerator
  validates_presence_of :platform_name, :platform_url

  has_one :photo, :as => :imageable, dependent: :destroy

  accepts_nested_attributes_for :photo
  sluggable_column :platform_name

  def img_thumb_url
    if self.photo.present? && self.photo.image.thumb.url.present?
      self.photo.image.thumb.url
    else
      "http://thedudeminds.de/images/no_image_available.png"
    end
  end

  def last_update
    if self.updated_at == nil 
      self.updated_at.to_formatted_s(:long)
    else 
      self.created_at.to_formatted_s(:long)
    end
  end

  def image_exist?
    (!self.photo.nil? && self.photo.image.url.present?) ? true : false
  end

end
