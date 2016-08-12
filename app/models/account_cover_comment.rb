class AccountCoverComment < ActiveRecord::Base

belongs_to :account_cover
belongs_to :account
validates_presence_of :account_id, :account_cover_id, :text

end
