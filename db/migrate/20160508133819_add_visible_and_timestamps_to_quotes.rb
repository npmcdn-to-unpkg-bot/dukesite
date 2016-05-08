class AddVisibleAndTimestampsToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :visible, :boolean, :default => false
    add_column :quotes, :created_at, :datetime
    add_column :quotes, :updated_at, :datetime
  end
end
