class ClassAttendance < ActiveRecord::Base
  belongs_to :gym_class
  belongs_to :account
  
   validates_presence_of :gym_class_id,  :account_id
end
