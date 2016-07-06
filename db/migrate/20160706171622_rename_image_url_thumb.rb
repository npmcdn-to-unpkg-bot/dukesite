class RenameImageUrlThumb < ActiveRecord::Migration
  def change
    rename_column :products, :image_url_thumb, :image_url_small
  end
end
