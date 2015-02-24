class AddPicToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :pic, :string
  end
end
