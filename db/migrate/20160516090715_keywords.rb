class Keywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :value
      t.belongs_to :keywordable, :polymorphic => true

      t.timestamps
    end
  end
end
