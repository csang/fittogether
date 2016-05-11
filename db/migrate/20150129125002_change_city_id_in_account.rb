class ChangeCityIdInAccount < ActiveRecord::Migration
  def change
	change_column :accounts, :city_id, :integer
  end
end
