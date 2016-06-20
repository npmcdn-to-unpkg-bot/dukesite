class Keyword < ActiveRecord::Base
  default_scope { order(updated_at: :desc) }
  include SlugGenerator

  belongs_to :keywordable, :polymorphic => true
  validates_presence_of :value

  sluggable_column :value
end
