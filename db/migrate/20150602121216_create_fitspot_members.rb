class CreateFitspotMembers < ActiveRecord::Migration
  def change
    create_table :fitspot_members do |t|
      t.integer :fitspot_id
      t.integer :account_id
      t.boolean :status, :default =>0
      t.boolean :seen, :default =>0

      t.timestamps
    end
  end
end
