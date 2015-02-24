class AddStateCodeToState < ActiveRecord::Migration
  def change
    add_column :states, :state_code, "char(4)"
    
  end
end
