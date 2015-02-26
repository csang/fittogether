class AddBelongToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :belong, :tinyint
   end
end
