class FixCloumnName < ActiveRecord::Migration
  def change
  def self.up
    rename_column :zipcodes, :name, :zipcode
  end
  end
end
