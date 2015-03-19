class RenameTypeToUserTypeInAccount < ActiveRecord::Migration
  def change
  rename_column :accounts, :type, :user_type
  end
end
