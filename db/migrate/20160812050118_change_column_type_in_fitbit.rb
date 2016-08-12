class ChangeColumnTypeInFitbit < ActiveRecord::Migration
  def change
  change_column :fitbits, :distance, :float
  end
end
