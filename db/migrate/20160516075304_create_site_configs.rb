class CreateSiteConfigs < ActiveRecord::Migration
  def change
    create_table :site_configs do |t|
      t.string :key
      t.text :value
      t.string :slug
      t.timestamps null: false
    end
  end
end
