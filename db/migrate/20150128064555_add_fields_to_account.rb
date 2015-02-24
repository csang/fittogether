class AddFieldsToAccount < ActiveRecord::Migration
  def change
  add_column :accounts, :gym_id, :integer
  add_column :accounts, :gym_location_id, :integer
  add_column :accounts, :industry_id, :integer
  add_column :accounts, :profession_id, :integer
  add_column :accounts, :relationship_id, :integer
  add_column :accounts, :goals, :string
  add_column :accounts, :reason, :string
  add_column :accounts, :dob, :date
  end
end
