class AddTypeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :type, :"tinyint(4)",  :default =>1


  end
end
