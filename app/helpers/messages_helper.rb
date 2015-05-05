module MessagesHelper

 def self_or_other(message)
 
message.account_id == @account.id ? "self" : "other"
end
 
def message_interlocutor(message)

message.account == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
end 

end
