class AddDurationToGymClasses < ActiveRecord::Migration
  def change
    add_column :gym_classes, :duration, :integer
  end
end
