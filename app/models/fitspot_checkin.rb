class FitspotCheckin < ActiveRecord::Base

belongs_to :account
belongs_to :fitspot
 
 validates_presence_of :account_id, :fitspot_id, :location
 
 
 scope :count_all, ->(account, date) do
	where("DATE(fitspot_checkins.created_at) = ? AND checkins.fitspot_id = ?",date ,  account).count
	end
	
end
