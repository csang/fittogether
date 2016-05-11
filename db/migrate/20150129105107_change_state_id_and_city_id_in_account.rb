class ChangeStateIdAndCityIdInAccount < ActiveRecord::Migration
  def change
  change_column :accounts, :state_id, "char(4)"
  change_column :accounts, :city_id, "char(4)"
  end
end
