class AddCityToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :city_id, :integer
    add_column :accounts, :state_id, :integer
    add_column :accounts, :country_id, :integer
    add_column :accounts, :age, :integer
    add_column :accounts, :gender, :string
    
  end
end
