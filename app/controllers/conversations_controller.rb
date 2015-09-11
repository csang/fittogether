class ConversationsController < ApplicationController
  before_filter :get_account
  include ApplicationHelper

 
  def index
    @conversation =	Conversation.involving(@account.id).order("id DESC")		
    if params[:cid].present?		
	    cid = Base64.decode64(params[:cid])
      @messages = Message.where(:conversation_id => cid)
    else
      @messages = @conversation.present? ? @conversation[0].messages.present? ? @conversation[0].messages : @conversation[1].messages : nil
		  
    end	
 
  end
    
	def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
	 
    render json: { conversation_id: @conversation.id }
	end
	 
	def show
		@conversation = Conversation.find(params[:id])
		@reciever = interlocutor(@conversation)
		@messages = @conversation.messages
		@message = Message.new
	end
	
	def new
    #to do
	end
	
	
	def getconv
    response.headers['Content-Type'] = 'text/event-stream' #for live streaming
    response.headers['Cache-Control'] = 'no-cache' #for clear browser cache
  
    @conversation =	Conversation.involving(@account.id).order("id DESC")	
		conv = []
		@conversation.each do |abc|
			conv.push(abc.id)
		end
    
    @message = Message.where("account_id != ? && is_read = ? && conversation_id IN (?)" , @account.id, 0, conv).first
  	#@account == @conversation.recipient ? @conversation.sender : @conversation.recipient

    response_arr = {}
    response_arr['img'] = '/assets/default.png'
    response_arr['id'] = @message.id
    response_arr['type'] = @message.account_id == @account.id ? "self" : "other"
    response_arr['m'] = @message.body
    response_arr['tym'] = @message.created_at.strftime("%H:%M %p")
    response_arr['name'] = @account.first_name
    if @message.present?
      render :json =>"data: #{response_arr.to_json}\n\n" 
      #render :json =>response_arr
	  else
      render :json=> 0
	  end	
  
	end	
  
  
  def updatestatus
    if request.xhr?  
      #abort(params.inspect)
      message = Message.find_by(id: params[:cid])
      message.is_read = 1
      message.save
      render :json => params[:cid]  and return     
    end
  end
	
  def del_conversation
    if request.xhr?  
      #abort(params.inspect)
      cid = Base64.decode64(params[:cid])			 
      @message = Message.where("conversation_id = ? and (status= ? or recipient_status = ?) ",cid,true,true )	
      if @message.present?
        @message.each do |message|
          type = message.account_id == @account.id ? "self" : "other"
          if type=='self' 
            message.update_attributes(status: false)
          else
            message.update_attributes(recipient_status: false)
          end
        end	
        render :json => cid  and return     
      else 
        render :json => 0  and return     
      end	
	
    end
  end
    
    
  def create_group_conv
    data = {'error' => true, 'msg' => 'Please Try Again'}  
    if params[:receiver_id] == 'group' # group already exist
       conv_id = Base64.decode64(params[:conversation_id])
        contacts = params['contacts']        
        contacts.each do |id|
          uid = Base64.decode64(id)
          ConversationMember.create!(:conversation_id=>conv_id, :account_id => uid)
        end
           data = {'error' => false, 'id' => conv_id}
    else
      recipient_id = Base64.decode64(params[:receiver_id])
      @conversation = Conversation.create!(:sender_id => @account.id, :recipient_id => recipient_id, :conversation_type => 1 )
      if @conversation.id.present?
        ConversationMember.create!(:conversation_id=>@conversation.id, :account_id => @account.id)
        ConversationMember.create!(:conversation_id=>@conversation.id, :account_id => recipient_id)
        contacts = params['contacts']        
        contacts.each do |id|
          uid = Base64.decode64(id)
          ConversationMember.create!(:conversation_id=>@conversation.id, :account_id => uid)
        end
      end  
           name = get_firstname_of_members(@conversation.id)
           data = {'error' => false, 'id' =>@conversation.id, 'cid' => Base64.encode64(@conversation.id.to_s), 'name' => name}
    end  
    #render json: { conversation_id: @conversation.id }
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
