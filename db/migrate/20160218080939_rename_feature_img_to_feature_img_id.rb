class RenameFeatureImgToFeatureImgId < ActiveRecord::Migration
  def change
    rename_column :showcases, :feature_img, :feature_img_url
  end
end
