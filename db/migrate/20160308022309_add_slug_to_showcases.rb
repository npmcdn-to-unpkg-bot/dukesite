class AddSlugToShowcases < ActiveRecord::Migration
  def change
    add_column :showcases, :slug, :string
    add_column :categories, :slug, :string
    add_column :images, :slug, :string
  end
end
