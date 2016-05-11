class AddStateCodeToCity < ActiveRecord::Migration
  def change
    add_column :cities, :state_code, "char(4)"
  end
end
