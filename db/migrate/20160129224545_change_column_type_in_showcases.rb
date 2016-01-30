class ChangeColumnTypeInShowcases < ActiveRecord::Migration
  def change
    change_column :showcases, :feature_img, :text
  end
end
