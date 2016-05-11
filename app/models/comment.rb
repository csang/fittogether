class Comment < ActiveRecord::Base

has_one :post
belongs_to :account

validates_presence_of :account_id, :post_id, :text

end
