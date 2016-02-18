class DeleteShowcaseIdFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :showcase_id
  end
end
