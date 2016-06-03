class CreateFitspotCovers < ActiveRecord::Migration
  def change
    create_table :fitspot_covers do |t|
      t.integer :fitspot_id
      t.integer :position

      t.timestamps
    end
  end
end
