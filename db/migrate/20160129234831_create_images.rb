class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.text :description
      t.text :url
      t.integer :showcase_id
      t.boolean :carousel, :default => false

      t.timestamps null: false
    end
  end
end
