class Appointment < ActiveRecord::Base
  belongs_to :account
  belongs_to :trainer, :foreign_key => :trainor_id, class_name: 'Account'
  
   validates :account_id, presence: true
  validates :trainor_id, presence: true
  validates :title, presence: true
end
