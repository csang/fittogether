class RenameDateAndAddEndDateToAppointment < ActiveRecord::Migration
  def change
   rename_column :appointments, :date, :start_date
    add_column :appointments, :end_date, :string
  end
end
