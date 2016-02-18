class AddDisplayToShowcases < ActiveRecord::Migration
  def change
    add_column :showcases, :show_on_landing_page, :boolean, :default => false
  end
end
