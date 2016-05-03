class AddVisibleToShowcases < ActiveRecord::Migration
  def change
    add_column :showcases, :visible, :boolean, :default => false
  end
end
