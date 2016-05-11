class CreateGymClasses < ActiveRecord::Migration
  def change
    create_table :gym_classes do |t|
      t.integer :account_id
      t.integer :trainer_id
      t.integer :specialty_id
      t.date :class_date
      t.string :class_time
      t.integer :total_slot
      t.boolean :status, :default => true  

      t.timestamps
    end
  end
end
