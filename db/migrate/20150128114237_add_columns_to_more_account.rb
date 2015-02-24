class AddColumnsToMoreAccount < ActiveRecord::Migration
  def change
  add_column :account_users, :trainer_contacts , :integer
  end
end
