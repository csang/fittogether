class FixZipcodeCloumnName < ActiveRecord::Migration
  def change
  rename_column :zipcodes, :name, :zipcode
  end
end
