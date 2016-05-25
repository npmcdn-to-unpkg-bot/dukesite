class RemoveImageFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :image
    remove_column :showcases, :image
    remove_column :social_network_accounts, :image
  end
end
