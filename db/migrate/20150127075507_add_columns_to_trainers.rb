class AddColumnsToTrainers < ActiveRecord::Migration
  def change
    add_column :account_trainers, :name, :string
    add_column :account_trainers, :state, :integer
    add_column :account_trainers, :city, :integer
    add_column :account_trainers, :zipcode, :integer
  end
end
