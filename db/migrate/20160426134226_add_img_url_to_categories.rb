class AddImgUrlToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :img_url, :text
  end
end
