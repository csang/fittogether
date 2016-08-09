class AddEmailVerifiedToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :email_verified, :boolean, default: false
  end
end
