class AddConfirmTokenToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :confirm_token, :string
    add_column :subscribers, :confirmed, :boolean, :default => false
  end
end
