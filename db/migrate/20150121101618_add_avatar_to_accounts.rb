class AddAvatarToAccounts < ActiveRecord::Migration
  def change
   add_column :accounts, :avatar, :string
   add_column :accounts, :account_url, :string 
   add_column :accounts, :user_name, :string
  end
end
