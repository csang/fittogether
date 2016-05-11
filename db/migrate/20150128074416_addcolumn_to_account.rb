class AddcolumnToAccount < ActiveRecord::Migration
  def change
	add_column :accounts, :company, :string
	add_column :accounts, :zipcode, :string
  end
end
