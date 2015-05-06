class AddNewFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :uid, :integer
    add_column :accounts, :oauth_token, :string
    add_column :accounts, :access_secret, :string
  end
end
