class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 #protect_from_forgery with: :null_session
 require "base64"

  def get_account
 #  city = Geocoder.coordinates('')
   
    @act ||= Account.find_by remember_token: (cookies[:auth_token]) if cookies[:auth_token]    
    if !@act.present?
		@act = Account.find_by fit_id: session[:fit_id]
		if !@act.present?
		   @act = Account.find_by email: session[:email]	   
		end
  	end
  	if @act.present? && @act.status == 0
  	    session.clear
  	    flash[:notice] = "Your account is deactivated. Kindly contact admin."
  	 	 redirect_to ('/login') and return
  	end 
  	
    @account ||= Account.where(:status=>1).find_by remember_token: (cookies[:auth_token]) if cookies[:auth_token]
    
    if !@account.present?
  	@account = Account.where(:status=>1).find_by fit_id: session[:fit_id]
  	end
  	
  	if !@account.present?
  	@account = Account.where(:status=>1).find_by email: session[:email]
  	end
  	
  	
  	@account_type = (session[:account].present?) ? session[:account]['account_type'] : nil;
  	if !@account.present?
  	    session.clear
  	   # flash[:notice] = "Please Sign In to continue to FitTogether."
  	 	 redirect_to ('/login') and return
  	end
  	 
    get_group = Group.where(:account_id => @account.id).collect(&:id)    
	if get_group.present?
		@cnt = GroupMember.where("group_id NOT IN (?) && account_id = ? && status = ? && seen =?  ", get_group, @account.id, false, false ).count
	else
		@cnt = GroupMember.where("account_id = ? && status = ? && seen =?  ",@account.id ,false, false ).count
	end    
     @cnt =  @cnt == 0 ? '' : @cnt     
     @event_cont = EventAttender.joins(:event).where("event_attenders.account_id = ? AND event_attenders.status =? AND events.account_id !=?", @account.id, false, @account.id).count     
     @event_cont =  @event_cont == 0 ? '' : @event_cont
     # event count
     @fitspot_cont = FitspotMember.where(:account_id => @account.id,:status => false, :seen => false ).count     
     @fitspot_cont =  @fitspot_cont == 0 ? '' : @fitspot_cont
     # for notification
      @fit_spot = FitspotMember.where(:account_id => @account.id,:status => false)
      @event_attender = EventAttender.joins(:event).where("event_attenders.account_id = ? AND event_attenders.status =? AND events.account_id !=?", @account.id, false, @account.id)
      
      get_group = Group.where(:account_id => @account.id).collect(&:id) 
      if get_group.present?
        @joining_request = GroupMember.where("group_id NOT IN (?) && account_id = ? && status = ?  ", get_group, @account.id, false )
      else
        @joining_request = GroupMember.where("account_id = ? && status = ?  ", @account.id, false )
      end
     # for follow notification 
     if @account.user_type == 2
		@follow = Friendship.where(:friend_id => @account.id, :seen => false)	
		
     end
    
  
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_error 404    
  end


  def render_error(status)
    respond_to do |format|
      format.html { render 'error_' + status.to_s() + '.html', :status => status, :layout => 'homepage'}
      format.all { render :nothing => true, :status => status }
    end
  end
  
  def status_method(id, model, status)
      @data = model.constantize.find(id)
		if status.to_i == 1
			 @data[:status] = 1
		else
			 @data[:status] = 0
		end
  
		if @data.update_attributes(:status => status)
			render :json=>'1' and return
		else
			render :json=>'0' and return	
		end
  end
  
  

def current_user
  
   
  @current_user  ||= Account.where(:status=>1).find_by remember_token: (cookies[:auth_token]) if cookies[:auth_token]
   @cr  ||= Account.find_by remember_token: (cookies[:auth_token]) if cookies[:auth_token]
  
   if @cr.present? && @cr.status == 0
   @current_user = nil
   end
 
  #@current_user = 'sandeep'
end

def get_profile_user

   @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
     if !@profileuser.present?
			redirect_to('/feed')
     else
		 @rating = Rating.where(trainer_id: @profileuser.id, account_id: @account.id).first 
		unless @rating 
		  @rating = Rating.create(trainer_id: @profileuser.id, account_id: @account.id, score: 0) 
		end
		
			@friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
			if !@friend.present?
				@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
			end		
     end
   
end  

  
  def email_settings(userid, slug)
    
     pre = AccountEmailSetting.where(:account_id=>userid)
    if !pre.present?
     return 123 
    else
		ip = AccountEmailSetting.where(:account_id=>userid).select(slug).first
		if ip.present? 
		  return ip[slug]
		  else 
		  return false
		  end	
	end	  
    
  end
  
  def get_frineds_ids(id)

   active_friend	= Friendship.where(:account_id => id)
   acfriend = active_friend.map(&:friend_id)
   passive_friend	= Friendship.where(:friend_id => id)
   pcfriend = passive_friend.map(&:account_id)
   
   return pcfriend + acfriend
  
  
  end

  



end
