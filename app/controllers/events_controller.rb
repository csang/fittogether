class EventsController < ApplicationController
before_action :get_account  

  def index    
    @events = Event.where("Date(event_date) > ? " ,Date.today)    
  end
  
  def create   
     fid = Base64.decode64(params[:event][:fitspot_id])      
      @event = Event.create(event_parm.merge(account_id: @account.id, :fitspot_id => fid))  
      if @event.save!
		 if params[:invite].present?
            fitspot_member =  FitspotMember.where(:fitspot_id => fid)
             if fitspot_member.present?
                fitspot_member.each do |gd|
                EventAttender.create(:account_id => gd.account_id, :event_id => @event.id, :status =>0)
            end
		end  
	  end
            flash[:notice] = "New Fitspot has been succesfully created."    
            redirect_to("/fitspots/" + params[:event][:fitspot_id] + "/events")	and return
      else		   
         flash[:error] = @event.errors.full_messages    
         redirect_to("/fitspots/" + params[:event][:fitspot_id] + "events")  and return         
      end      
  end
  
   def give_event_kudos # add delete kudos
		if request.xhr?    
		  event_id = Base64.decode64(params[:event_id])     
		  kudos =  EventKudo.where(:event_id=>event_id, :account_id=> @account.id).first   
		  if kudos.present? && kudos.destroy 
			  render :json => 1  and return    
		  else
			  kudos = EventKudo.create(:event_id=>event_id, :account_id=> @account.id)
			  if kudos 
			  	 render :json => 1  and return    
			  else
			      flash[:error] = kudos.errors.full_messages.first
			  end  
		  end
		
		end
  
  end
  
   def create_comment_on_event
     if request.xhr?     
      id = Base64.decode64(params[:event_id])
      @comments =  EventComment.create(:account_id=>@account.id,:text=>params[:text],:event_id=>id)
      if @comments.save!
         respond_to do |format|
            @comment =  EventComment.find(@comments.id)
            format.js {  render 'create_comment_on_event' }
          end
      else		   
        render :json => @comments.errors.full_messages  and return     
      end  
     else
       redirect_to request.env['HTTP_REFERER'] and return
     end   
    end

 
  def show
  end
  
  def  destroy
  #abort(params[:id].inspect)
   if request.xhr?    
      evnt = Event.where(:id=>params[:id], :account_id => @account.id).first
      if evnt.destroy 
        render :json => params[:id]  and return      
      else
        render :json => 0  and return     
      end    
    end    
    
  
  end
  
   def delete_event_comment    
    if request.xhr?    
      id = Base64.decode64(params[:id])   
      @cmt = EventComment.where(:id=>id, :account_id => @account.id).first
      if @cmt.destroy 
        render :json => id  and return      
      else
        render :json => 0  and return     
      end    
    end    
  end
  
  def add_del_attending
   if request.xhr?     
     id = Base64.decode64(params[:id])   
     if params[:type] =='add'         
        @member = EventAttender.where(:id=> id,:account_id =>@account.id).first
         if @member.present?
          if  @member.update_attribute(:status, true)
             render :json => 1  and return     
         else
           render :json => 0  and return   
         end 	
        else
        @member = EventAttender.create(:id=> id,:account_id =>@account.id, :status => true, :seen => true)		
            if @member.save
              render :json => 1  and return     
            else
              render :json => 0  and return   
            end 	
        end  
     else
        @member = EventAttender.where(:id=> id,:account_id =>@account.id).first
        if @member.present?
			if @member.delete
			 render :json => 1  and return     
			else
			 render :json => 0  and return   
			end 
		else
			 render :json => 0  and return   	
		end		
     end
        
   else
      redirect_to('/feed')	 
   end
    
    
  end
  
   private
   def event_parm
    params.require(:event).permit(:title, :description, :event_image,  :event_date, :event_start_time , :event_end_time)
  end
  
end
