class AddMobileToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :mobile, :integer
  end
end
