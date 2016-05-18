class AddSlugToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :slug, :string
  end
end
