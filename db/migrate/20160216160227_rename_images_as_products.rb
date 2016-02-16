class RenameImagesAsProducts < ActiveRecord::Migration
  def change
    rename_table :images, :products
  end
end
