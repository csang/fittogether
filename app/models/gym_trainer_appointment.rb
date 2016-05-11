class GymTrainerAppointment < ActiveRecord::Base

 belongs_to :account
 belongs_to :trainer, class_name: "Account", foreign_key: "trainer_id"
 validates_presence_of :trainer_id,  :account_id, :appointment_date , :total_slot 
 
 scope :between, -> (id, trainer_id,date) do
		where("(gym_trainer_appointments.account_id = ? AND gym_trainer_appointments.trainer_id =? AND Date(appointment_date) =?)", id,trainer_id, Date.parse(date))
    end
  
 
end
