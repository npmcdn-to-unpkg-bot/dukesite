class Showcase < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
  scope :visible_on_landing_page, -> { visible.where(show_on_landing_page: true) }
  include SlugGenerator
  validates_presence_of :title

  has_many :product_showcases
  has_many :products, through: :product_showcases
  
  has_many :keywords, :as => :keywordable, dependent: :destroy

  mount_uploader :image, ImageUploader
  sluggable_column :title
end
