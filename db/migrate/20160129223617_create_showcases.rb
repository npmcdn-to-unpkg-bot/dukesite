class CreateShowcases < ActiveRecord::Migration
  def change
    create_table :showcases do |t|
      t.string :title
      t.integer :feature_img

      t.timestamps null: false
    end
  end
end
