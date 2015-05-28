class Challenge < ActiveRecord::Base
  belongs_to :category
  belongs_to :account
  belongs_to :sender, :foreign_key => :account_id, class_name: 'Account'
  belongs_to :recipient, :foreign_key => :to_id, class_name: 'Account'
  
  validates :account_id, presence: true
  validates :to_id, presence: true
  validates :category_id, presence: true
  
  	scope :involving, ->(account) do
	where("valid_till >=? AND sender_status != ? AND (challenges.account_id =? OR challenges.to_id =?) ",Date.today, false , account,account)
	end
end
