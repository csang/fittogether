class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :title
      t.string :description
      t.string :date
      t.string :time
      t.integer :account_id
      t.integer :trainor_id
      t.integer :status , limit: 4, default: 1

      t.timestamps
    end
  end
end
