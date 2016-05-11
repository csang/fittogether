class AddEmailToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :email, :string
  end
end
