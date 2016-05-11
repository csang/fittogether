class Api::V1::ConversationsController < Api::V1::BaseController
  before_action :authenticate_with_token!
  before_action :check_post, :except => [:index,:show, :del_conversation] # check if request.post?
 
  #cid = conversation id
  #mid = message id
 def index
 
    conversation =	Conversation.involving(current_user.id).order("id DESC")		
    if params[:cid].present?		
	    cid = Base64.decode64(params[:cid])
        messages = Message.where(:conversation_id => cid)
    else
        messages = conversation.present? ? conversation[0].messages.present? ? conversation[0].messages : conversation[1].messages : nil		  
    end	
       render :json => {conversation: conversation, messages: messages  }  and return
  end
    
    
 def create
 
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      conversation = Conversation.create!(conversation_params)
    end
	 
   render :json => {conversation: conversation  }  and return
   
 end
	
	
	 
	def show
		conversation = Conversation.find(params[:cid])
		reciever = interlocutor(conversation)
		messages = conversation.messages
		render :json => {conversation: conversation, reciever: reciever, messages: messages }  and return
		
	end
	
	
  def updatestatus # update message status to read
        
      
      message = Message.find_by(id: params[:mid])
      if message.present?
		  message.is_read = 1
		  if message.save
		   render :json => { success: "Status Update Successfully!"}  and return     
		  end
	  else
	      render :json => {errors: "Please Try Again!"} 	  
	  end	  
		  
      
  end
	
  def del_conversation
  
      cid = Base64.decode64(params[:cid])			 
      message = Message.where("conversation_id = ? and (status= ? or recipient_status = ?) ",cid,true,true )	
      if message.present?
         message.each do |message|
          type = message.account_id == current_user.id ? "self" : "other"
          if type=='self' 
            message.update_attributes(status: false)
          else
            message.update_attributes(recipient_status: false)
          end
        end	
        render :json => cid  and return     
      else 
       render :json => {errors: "No Such Conversation!"} 	 
      end
     end 	
	
    
  def create_group_conv # group conversation 
  
    data = {'error' => true, 'msg' => 'Please Try Again'}  
    if params[:receiver_id] == 'group' # group already exist
       conv_id = Base64.decode64(params[:conversation_id])
        contacts = params['contacts']    # all the members of group    
        contacts.each do |id|
          uid = Base64.decode64(id)
          ConversationMember.create!(:conversation_id=>conv_id, :account_id => uid)
        end
           data = {'error' => false, 'id' => conv_id}
    else
      recipient_id = Base64.decode64(params[:receiver_id])
      conversation = Conversation.create!(:sender_id => current_user.id, :recipient_id => recipient_id, :conversation_type => 1 )
      if conversation.id.present?
        ConversationMember.create!(:conversation_id=>conversation.id, :account_id => current_user.id)
        ConversationMember.create!(:conversation_id=>conversation.id, :account_id => recipient_id)
        contacts = params['contacts']        
        contacts.each do |id|
          uid = Base64.decode64(id)
          ConversationMember.create!(:conversation_id=>conversation.id, :account_id => uid)
        end
      end  
           name = get_firstname_of_members(conversation.id)
           data = {'error' => false, 'id' =>conversation.id, 'cid' => Base64.encode64(conversation.id.to_s), 'name' => name}
    end  
   render :json => data
  end

   
 
  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
	 
  def interlocutor(conversation)
    @account == conversation.recipient ? conversation.sender : conversation.recipient
  end 
end
