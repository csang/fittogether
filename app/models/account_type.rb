class AccountType < ActiveRecord::Base

	has_one :account_user
	has_one :account_gym

end
