class ConversationMember < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :account
  validates_presence_of :conversation_id
  validates_presence_of :account_id
end
