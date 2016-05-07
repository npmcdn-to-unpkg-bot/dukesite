class AddImageToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :image, :string
    remove_column :quotes, :image
  end
end
