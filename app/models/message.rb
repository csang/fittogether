class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :account
  
   validates_presence_of :body, :conversation_id, :account_id
   
 
end
