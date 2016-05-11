class CreateGymTrainerAppointments < ActiveRecord::Migration
  def change
    create_table :gym_trainer_appointments do |t|
      t.integer :account_id
      t.integer :trainer_id
      t.date :appointment_date
      t.integer :total_slot
      t.string :morning_start_time
      t.string :morning_end_time
      t.string :afternoon_start_time
      t.string :afternoon_end_time
      t.string :evening_start_time
      t.string :evening_end_time

      t.timestamps
    end
  end
end
