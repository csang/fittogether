class AddFieldsToAccountGym < ActiveRecord::Migration
  def change
  add_column :account_gyms, :address, :string
  add_column :account_gyms, :specialties, :string
  add_column :account_gyms, :franchise, "int(11)"
  add_column :account_gyms, :groupclasses, :string
  add_column :account_gyms, :dancetypes, :string
  add_column :account_gyms, :train_client_at_your_gym, "int(11)"
  add_column :account_gyms, :fee, :float
  add_column :account_gyms, :amenities, :string
  add_column :account_gyms, :timings, :string
  end
end
