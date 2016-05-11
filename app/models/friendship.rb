class Friendship < ActiveRecord::Base
	    belongs_to :account
		belongs_to :friend, :class_name => "Account"
		validates_presence_of :account_id, :friend_id
 
		
		scope :if_already, ->(to_id, current_user) do
			where("(friendships.account_id =? And friendships.friend_id =?) OR (friendships.account_id =? And friendships.friend_id =?)",to_id,current_user,current_user,to_id)
	   end

end
