class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :location
      t.integer :account_gym_id
      t.integer :account_id

      t.timestamps
    end
  end
end
