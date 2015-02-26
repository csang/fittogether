class Category < ActiveRecord::Base
	has_one :account_user
end
