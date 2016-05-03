class AddSlugToSocialNewtworkAccounts < ActiveRecord::Migration
  def change
    add_column :social_network_accounts, :slug, :string
  end
end
