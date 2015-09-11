require 'sse_app/sse.rb' 
class MessagesController < ApplicationController
  before_filter :get_account
  include ActionController::Live
  include ActionView::Helpers::DateHelper
 
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
    if !params[:conversation_id].present? 
       recipient_id = Base64.decode64(params[:mtype])
       if Conversation.between(@account.id,recipient_id).present?
          conversation = Conversation.between(@account.id,recipient_id).first
       else
          conversation = Conversation.create!(:sender_id => @account.id, :recipient_id => recipient_id)
       end
       cid = conversation.id
    else
      cid = Base64.decode64(params[:conversation_id])		
    end
    mtype = params[:mtype]=='group' ? 1 : 0
		@message = Message.create(:body =>params[:body], :account_id =>@account.id, :conversation_id => cid, :message_type => mtype)	
	respond_to do |format|
    
    if params[:msg].present?
            
       format.js  {render 'send_chat_msg'}
    else
       
       format.js { render 'send_message' }
    end	
     
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
  
  
  def check
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Cache-Control'] = 'no-cache' #for clear browser cache
    sse = SimpleApp::SSE.new(response.stream)
    begin
      20.times do
       # @conversation =	Conversation.involving(@account.id).order("id DESC")	
       # conv = []
        #@conversation.each do |abc|
       #   conv.push(abc.id)
       # end
        messages = Message.where("account_id != ? && created_at > ?", @account.id, 3.seconds.ago)
      #  messages = Message.where("account_id != ? && conversation_id IN (?) && created_at > ? " , @account.id,  conv, 3.seconds.ago).first
      
        unless messages.empty?
          mess = {}
          messages.each do |mesg|
              mess['body'] = mesg.body
              mess['tym'] = mesg.created_at.strftime("%H:%M %p")
              mess['conversation_id'] = mesg.conversation_id
              mess['name'] = mesg.account.first_name
              mess['id'] = mesg.account.id
              mess['mid'] = mesg.id
          end
          sse.write({messages: mess.as_json}, {event: 'refresh'})
         
        end
        sleep 3
      end
    rescue IOError
      # When the client disconnects, we'll get an IOError on write
    ensure
      sse.close
    end
  end
  
  
def get_last_five_msg
   if request.xhr?  
    @messages = Message.where("conversation_id = ?", params[:conversation_id]).limit(5).order('id DESC').reverse
  
    if @messages.present?
      respond_to do |format|
        format.js
      end
    end
   end
  
end  


  
 
private
 
	def message_params
    params.permit(:body)
	end 

end
