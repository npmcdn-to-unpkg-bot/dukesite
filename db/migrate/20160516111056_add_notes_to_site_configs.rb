class AddNotesToSiteConfigs < ActiveRecord::Migration
  def change
    add_column :site_configs, :note, :string
    add_column :site_configs, :maxlength, :integer
  end
end
