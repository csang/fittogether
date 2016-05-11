class GymClass < ActiveRecord::Base
 belongs_to :account
 belongs_to :specialty
  belongs_to :trainer, class_name: "Account", foreign_key: "trainer_id"
 validates_presence_of :specialty_id, :account_id, :trainer_id, :class_date	, :class_time, :total_slot 
end
