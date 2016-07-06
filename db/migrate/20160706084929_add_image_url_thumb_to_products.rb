class AddImageUrlThumbToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image_url_thumb, :string
  end
end
