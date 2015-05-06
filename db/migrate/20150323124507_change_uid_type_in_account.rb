class ChangeUidTypeInAccount < ActiveRecord::Migration
  def change
  change_column :accounts, :uid, :string
  end
end
