class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :subject
      t.text :content
      t.boolean :sent, :default => false
      t.datetime :sent_at

      t.timestamps null: false
    end
  end
end
