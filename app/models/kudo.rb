class Kudo < ActiveRecord::Base

has_one :post
belongs_to :account

validates_presence_of :account_id, :post_id
validates_uniqueness_of :account_id, scope: :post_id

end
