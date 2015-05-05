class MessagesController < ApplicationController
  before_filter :get_account
 
	def create
	 if request.xhr?  
		 sid = Base64.decode64(params[:sender_id])
		 rid = Base64.decode64(params[:recipient_id])		
     #abort(params.inspect)
			if Conversation.between(sid,rid).present?
				@conversation = Conversation.between(sid,rid).first
			else
				@conversation = Conversation.create(:sender_id => sid,:recipient_id =>rid)
			end
	
		@message = @conversation.messages.build(message_params)
		@message.account_id = @account.id
		if @message.save!  
         	render :json => 1  and return     
		else
		    render :json => 0  and return   
		end 	
		 
		
		end
	end
	
	def send_message
	 if request.xhr?  
		cid = Base64.decode64(params[:conversation_id])			 
		@message = Message.create(:body =>params[:body], :account_id =>@account.id, :conversation_id => cid)	
			
	respond_to do |format|
      format.js       
     end
		end
	end
	
	
=begin
	Function Name		:		checkmsgcount
	
=end 
	def checkmsgcount
	
		response.headers['Content-Type'] = 'text/event-stream' #for live streaming
		response.headers['Cache-Control'] = 'no-cache' #for clear browser cache
		@conversation =	Conversation.involving(@account.id).order("id DESC")
	
		conv = []
		@conversation.each do |abc|
			conv.push(abc.id)
		end
    
	   cont = Message.where("account_id != ? && is_read = ? && conversation_id IN (?)" , @account.id, 0, conv).count
		if cont > 0
			render :text=> "retry: 3000\ndata: {\"totalMsg\":"+cont.to_s+"}\n\n" 
		else
			render :json=>0
		end	
	end
	
	def del_message
	 if request.xhr?  
		#abort(params.inspect)
		mid = Base64.decode64(params[:mid])			 
		type = params[:type]			 
		@message = Message.find(mid)	
		if params[:type]=='self' 
			@message.update_attributes(status: false)
		else
			@message.update_attributes(recipient_status: false)
		end
			
	  if @message 
		render :json => mid  and return     
	  else
		render :json => 0  and return     
	  end
		end
	end
 
private
 
	def message_params
	params.permit(:body)
	end 

end
