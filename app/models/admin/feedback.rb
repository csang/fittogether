class Admin::Feedback < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
      validates_presence_of :category_id, :account_id, :feedback
end
