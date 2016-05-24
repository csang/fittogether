class CreateFitspotCheckins < ActiveRecord::Migration
  def change
    create_table :fitspot_checkins do |t|
      t.string :location
      t.integer :fitspot_id
      t.integer :account_id

      t.timestamps
    end
  end
end
