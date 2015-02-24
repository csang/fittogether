class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 #protect_from_forgery with: :null_session

  def get_account
    @act ||= Account.find_by remember_token: (cookies[:auth_token]) if cookies[:auth_token]    
    if !@act.present?
  	@act = Account.find_by fit_id: session[:fit_id]
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
  	
  	@account_type = (session[:account].present?) ? session[:account]['account_type'] : nil;
  	if !@account.present?
  	    session.clear
  	    flash[:notice] = "Please Sign In to continue to FitTogether."
  	 	 redirect_to ('/login') and return
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
		if @data.update_attributes(:status => @data[:status].to_i)
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


end
