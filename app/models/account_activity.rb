class AccountActivity < ActiveRecord::Base
serialize :activity_id, Array
belongs_to :account
end
