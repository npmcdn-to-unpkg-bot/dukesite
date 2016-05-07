class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :title
      t.text :description
      t.string :image
    end
  end
end
