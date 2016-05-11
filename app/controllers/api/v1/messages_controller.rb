class Api::V1::MessagesController < Api::V1::BaseController
   before_action :authenticate_with_token!
   before_action :check_post, :except => [:index,:show, :checkmsgcount , :del_message, :get_last_five_msg, :get_chat_box_values] # check if request.post?

	def create
	    sid = Base64.decode64(params[:sender_id])
	    rid = Base64.decode64(params[:recipient_id])		
    	if Conversation.between(sid,rid).present?
			conversation = Conversation.between(sid,rid).first
		else
			conversation = Conversation.create(:sender_id => sid,:recipient_id =>rid)
		end
		message = conversation.messages.build(message_params)
		message.account_id = current_user.id
		if  message.save!  
         	 render :json => {success: "Message deliver Succesfully!"}   
		else
		     render :json => {errors: "Please Try Again!"}  and return
		end 	

	end
	
	def send_message
	    if !params[:conversation_id].present? 
        recipient_id = Base64.decode64(params[:recipient_id]) #mtype 
         if Conversation.between(current_user.id,recipient_id).present? #check if already conversation present
           conversation = Conversation.between(current_user.id,recipient_id).first
         else
           conversation = Conversation.create!(:sender_id => current_user.id, :recipient_id => recipient_id) # create new if not already
         end
       cid = conversation.id
      else
       cid = Base64.decode64(params[:conversation_id])		
      end
       mtype = params[:mtype]=='group' ? 1 : 0
	    if Message.create(message_params.merge(:account_id => current_user.id, :conversation_id => cid, :message_type => mtype))	
	       render :json => {success: "Message sent Succesfully!"}   
		else
		   render :json => {errors: "Please Try Again!"}  and return
		end 	

    end
	
  def checkmsgcount # count undread messsages for current user
	  conversation =	Conversation.involving(current_user.id).order("id DESC") # all conversations for current user
	  conv = [] # array for in query 
	  conversation.each do |abc|
	    conv.push(abc.id)
	  end
      cont = Message.where("account_id != ? && is_read = ? && conversation_id IN (?)" , current_user.id, 0, conv).count
		if cont > 0
			render :text=> cont 
		else
			render :json=> 0
		end	
  end # end of message count
	
	def del_message # for user it is delte but in db it change status to false	
		mid = Base64.decode64(params[:id])			 
		type = params[:type]			 
		message = Message.find(mid)	
		if params[:type]=='self' 
			message.update_attributes(status: false)
		else
			message.update_attributes(recipient_status: false)
		end
			
	    if message 
		   render :json => mid  and return     
	    else
		   render :json => {errors: "Please Try Again!"}  and return
	   end	
	end
  

def get_last_five_msg # some where need to show last fine msg only

    messages = Message.where("conversation_id = ?", params[:conversation_id]).limit(5).order('id DESC').reverse # conversation id is only parm
    if messages.present?
        msgs = Array.new #main arrays		
		messages.each do |msg|
	    	hash = {}
			hash[:message] = msg
			hash[:user] = get_user_array(msg.account)
			msgs.push(hash) #push message and correspondance user and user into array
        end
        render :json => msgs  and return     
    else
       render :json => {errors: "No message found!"}  and return
    end
 
end  

def get_chat_box_values # return first name , cid and account id
   
      conv = Conversation.find(params[:conversation_id]);
      mess = {}
      mess['cid'] = Base64.encode64(params[:conversation_id])
    
      if conv.conversation_type == 1 
        mess['aid'] = 'group'
        mess['names'] = get_firstname_of_members(params[:conversation_id])   
      else 
        id = conv.sender.id == @account.id ? conv.recipient_id : conv.sender.id
        mess['aid'] = Base64.encode64(id.to_s)
        acc_name = Account.select(:first_name).find(id)
        mess['names'] = acc_name.first_name.capitalize
      end
    
     render :json => mess  and return
    
end
  
 
private
 
	def message_params
    params.permit(:body)
	end 

end
