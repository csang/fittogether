class Checkin < ActiveRecord::Base

 
belongs_to :account
belongs_to :accountgym
 
 validates_presence_of :account_id
 validates_presence_of :account_gym_id
 
 scope :count_all, ->(account, date) do
	where("DATE(checkins.created_at) = ? AND checkins.account_gym_id = ?",date ,  account).count
	end
 
end
