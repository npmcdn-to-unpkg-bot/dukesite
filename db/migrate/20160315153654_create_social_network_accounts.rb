class CreateSocialNetworkAccounts < ActiveRecord::Migration
  def change
    create_table :social_network_accounts do |t|
      t.string :platform_name
      t.text :platform_url
      t.text :img_url

      t.timestamps null: false
    end
  end
end
