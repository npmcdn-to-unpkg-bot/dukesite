class CreateProductShowcases < ActiveRecord::Migration
  def change
    create_table :product_showcases do |t|
      t.belongs_to :product, index: true
      t.belongs_to :showcase, index: true

      t.timestamps null: false
    end
  end
end
