class AccountGoal < ActiveRecord::Base
  belongs_to :account
  belongs_to :goal
   belongs_to :sender, :foreign_key => :account_id, class_name: 'Account'
  belongs_to :recipient, :foreign_key => :for_id, class_name: 'Account'
  validates_presence_of :account_id, :goal_id, :qty
end
