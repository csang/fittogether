class AddActivityidsToFitspot < ActiveRecord::Migration
  def change
    add_column :fitspots, :activity_ids, :string
  end
end
