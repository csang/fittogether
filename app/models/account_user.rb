class AccountUser < ActiveRecord::Base

	belongs_to :account
	belongs_to :title
	belongs_to :company
	belongs_to :gym
	belongs_to :relationship

end
