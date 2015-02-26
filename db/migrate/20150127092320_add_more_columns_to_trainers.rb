class AddMoreColumnsToTrainers < ActiveRecord::Migration
  def change
	add_column :account_trainers, :account_id, :integer
    remove_column :account_trainers, :name, :string
    remove_column :account_trainers, :state, :integer
    remove_column :account_trainers, :city, :integer
    remove_column :account_trainers, :zipcode, :integer
    add_column :account_gyms, :account_id, :integer
  end
end
