class AddBioToAccountPrivacy < ActiveRecord::Migration
  def change
    add_column :account_privacies, :bio, :tinyint
  end
end
