class RemoveImgUrlsAndImagesTable < ActiveRecord::Migration
  def change
    remove_column :categories, :img_url
    remove_column :showcases, :feature_img_url
    remove_column :social_network_accounts, :img_url
    add_column :categories, :image, :string
    add_column :showcases, :image, :string
    add_column :social_network_accounts, :image, :string

    drop_table :images
  end
end
