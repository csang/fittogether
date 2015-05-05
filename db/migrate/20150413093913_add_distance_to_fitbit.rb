class AddDistanceToFitbit < ActiveRecord::Migration
  def change
    add_column :fitbits, :distance, :integer
  end
end
