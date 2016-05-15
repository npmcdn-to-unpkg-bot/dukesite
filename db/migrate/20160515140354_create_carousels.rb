class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :slug
      t.boolean :visible, :default => false
      t.timestamps null: false
    end

    remove_column :photos, :carousel
  end
end
