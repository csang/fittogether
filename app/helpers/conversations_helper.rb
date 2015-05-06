module ConversationsHelper

def interlocutor(conversation)
	@account == conversation.recipient ? conversation.sender : conversation.recipient
	end 
  
  
	
def getmessage(conid)
	@msg = Message.where(:conversation_id =>conid).last
  if @msg.present?
    typ = @msg.account_id == @account.id ? "self" : "other"
      
    if typ=='self' && @msg[:status]==true    
       return  @msg[:body]
    elsif  typ=='other' && @msg[:recipient_status]==true
       return  @msg[:body]
    else
        return 
    end  
  else
    return 
  end    
	
	
end	

def updateread(conversation)

	conv = []
	conversation.each do |abc|
    conv.push(abc.id)
    end
    
     Message.where("account_id != ? && is_read = ? && conversation_id IN (?)" , @account.id, 0, conv).update_all(:is_read =>1)
end

def countaliveconversation (conv)
 @mcc = Message.where("conversation_id = ? and ((account_id =? and status =1) or (account_id !=? and recipient_status =1))" ,conv, @account.id,@account.id).count
  return @mcc
end  
	
end
