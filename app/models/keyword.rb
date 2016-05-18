class Keyword < ActiveRecord::Base
  include SlugGenerator

  belongs_to :product
  belongs_to :site_config

  belongs_to :keywordable, :polymorphic => true
  validates_presence_of :value

  sluggable_column :value
end
