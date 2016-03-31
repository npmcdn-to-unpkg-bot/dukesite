class AddVisibleToSocialNetworkAccounts < ActiveRecord::Migration
  def change
    add_column :social_network_accounts, :visible, :boolean, :default => false
  end
end
