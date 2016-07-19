class AddLatLongToFitspot < ActiveRecord::Migration
  def change
    add_column :fitspots, :latitude, :float
    add_column :fitspots, :longitude, :float
  end
end
