class GroupMember < ActiveRecord::Base
  
  belongs_to :group
  belongs_to :account
 validates_presence_of :account_id
 validates :group_id, uniqueness: { scope: :account_id }
 belongs_to :inviter, :foreign_key => :inviter_id, class_name: 'Account'
 
 scope :members, ->(gid) do 
	where("status = ? AND group_id =? ",true , gid).count
	end
  
end
