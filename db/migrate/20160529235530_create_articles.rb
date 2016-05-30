class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :subtitle
      t.text :content
      t.boolean :published, :default => false
      t.datetime :published_at
      t.string :slug
      t.belongs_to :articleable, :polymorphic => true
    end
  end
end
