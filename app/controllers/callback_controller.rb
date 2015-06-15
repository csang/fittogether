class CallbackController < ApplicationController
  def store
    # example request.env['omniauth.auth'] in https://github.com/auth0/omniauth-auth0#auth-hash
    # id_token = session[:userinfo]['credentials']['id_token']
    # store the user profile in session and redirect to root
	#abort(request.env['omniauth.auth'].inspect)
    issocial = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['isSocial']    
    connection = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['connection']    
   
   
    if issocial && connection == "fitbit"
			session[:oauth_token] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['access_token']  
			session[:oauth_secret] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['access_token_secret']  
			session[:uid] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['user_id']  
			
			redirect_to('/feed') and return	
	end	
    session[:fit_id] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['user_id']
    if session[:remember_me].present?
    remember_token = Account.encrypt("#{Time.now.utc}")
     @user = Account.find_by_fit_id(session[:fit_id])    
		if @user.present?
		@user.update_attribute(:remember_token, remember_token)	
		cookies[:auth_token] = { :value   => remember_token,
									 :expires => 20.years.from_now.utc }
		end    
	            
    end
    
    if issocial
     	if connection == "twitter"
				fullname = request.env['omniauth.auth']['info']['name'].split(' ')
				session[:first_name] = fullname[0]
				session[:last_name] = fullname[1]
			else
				session[:first_name] = request.env['omniauth.auth']['info']['first_name']
				session[:last_name] = request.env['omniauth.auth']['info']['last_name']
			end
				#abort(request.env['omniauth.auth'].inspect)
				session[:avatar] = request.env['omniauth.auth']['info']['image'].sub('https://','')
				session[:user_name] = session[:first_name] + '_' + connection
				session[:email] = request.env['omniauth.auth']['info']['email']
				session[:provider] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['provider']
      
				@authorization = Authorization.find_by_provider_and_uid(session[:provider], session[:fit_id])
				if @authorization
				   redirect_to('/feed')
				else
					
				  user = Account.new :fit_id => session[:fit_id], :first_name => session[:first_name], :last_name => session[:last_name], :email => session[:email],:user_name => session[:user_name],:pic => session[:avatar]
				  user.authorization.build :provider => session[:provider], :uid => session[:fit_id]
				  user.save
				  @accountUser = AccountUser.new :account_id => user.id   
				  @accountUser.save
				 redirect_to('/feed') and return
				end
    else  # for other users
      @user =  Account.find_by fit_id: session[:fit_id]
      session[:account] = request.env['omniauth.auth']['extra']['raw_info']
      if @user.blank?
      @account = Account.new
      @account['fit_id'] = session[:fit_id]
      @account['first_name'] = session[:account][:first_name]
      @account['last_name'] = session[:account][:last_name]
      @account['user_name'] = session[:account][:username] 
      @account['email'] = session[:account][:email] 
      @account['user_type'] = session[:account][:account_type].to_i
        if @account.save
          case session[:account][:account_type].to_i
          when 2
            @model = AccountTrainer.new
          when 3  
            @model = AccountGym.new
          else
           @model = AccountUser.new
          end
          @model['account_id'] = @account.id   
          @model.save
        if session[:account][:account_type].to_i == 3
               redirect_to('/about') and return 
            else 
               redirect_to('/feed') and return
            end
        else
          redirect_to('/login')  and return
        end
      else
        redirect_to('/feed') and return
      end 
   end
    
  end

  def failure
    #show a failure page
    @error_msg = request.params['message']
    flash[:notice] = @error_msg
     redirect_to('/login') and return
  end
  
  def omniauth_failure
    @error_msg = request.params['error']
    #flash[:notice] = @error_msg
     redirect_to('/login') and return
  end
  
  def set_remember
  session[:remember_me] = 1; 
  	render :json => {
        :data => 'sfsd'
      }
  end
end
