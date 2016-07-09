class AddUserLocationToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :user_location, :string
  end
end
