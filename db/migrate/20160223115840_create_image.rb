class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.text :description
      t.text :url
      t.boolean :set_as_carousel, :default => false
      t.boolean :quote, :default => false
      t.timestamps null: false
    end

    remove_column :products, :carousel
  end
end
