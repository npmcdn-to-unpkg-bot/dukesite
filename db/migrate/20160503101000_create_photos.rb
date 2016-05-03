class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.boolean :carousel, :default => false
      t.belongs_to :imageable, :polymorphic => true
    end
  end
end
