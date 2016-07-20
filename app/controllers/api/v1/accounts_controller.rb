class Api::V1::AccountsController < Api::V1::BaseController

 def index
   account = Account.all
   render json: account
   end

   def show

   account = Account.find(params[:id])
   render json: account
   end
   
   ## Saving the basic info
   def basic_info
   end
   
   ## After login, get the user details with userid 
   def login
   width_original = width_large = height ='';
		if  params[:fit_id]
			accounts = Account.where("fit_id = ?", params[:fit_id]).first
			
			if accounts.present?
				authorization = Authorization.where("uid = ?", accounts.id).first
				
				if accounts.avatar.present? 
					width_original  = accounts.avatar_geometry(:original).width 
					width_large = accounts.avatar_geometry(:large).width 
					height = accounts.avatar_geometry(:large).height
				end
					if authorization.present?
						render :json => { user: accounts, width_original: width_original, width_large: width_large,  height: height, social: '1'} and return
					end
					render :json => { user: accounts, width_original: width_original, width_large: width_large,  height: height} and return
				else 
				render :json => { errors: "Something went wrong" } and return
			end
		else 	
			render :json => { errors: "Something went wrong" } and return
		end	 
   end
   
   def signup
     connection = params[:connection]
     if connection == 'social'
		userId = params[:userId].split('|')
		authorization = Authorization.find_by_provider_and_uid(params[:provider], userId)
		if authorization
				render :json => {success: "Sucessfully login"}  and return
		else
			account = Account.new
			account['fit_id'] = userId[1]
			account['first_name'] = params[:first_name]
			account['pic'] = params[:pic]
			account['user_name'] = params[:username]
			account['email'] = params[:email]
			account['user_type'] = params[:user_type]
			if account.save
					authorization = Authorization.new
					authorization['provider'] = params[:provider] 
					authorization['uid'] = userId[1]
					authorization['account_id'] = account.id
					authorization.save
					account_user = AccountUser.new :account_id => account.id
					account_user.save	
				render :json => {success: "Sucessfully data saved"}  and return
			else
				render :json => { errors: "Invalid email or password" } and return
			end
		end
     else
		## saving signup user with social 
		account = Account.new
		userId = params[:userId].split('|')
		account['fit_id'] = userId[1]
		account['first_name'] = params[:first_name]
		account['last_name'] = params[:last_name]
		account['user_name'] = params[:username]
		account['email'] = params[:email]
		account['user_type'] = 1
		 if account.save
			case params[:user_type].to_i
			when 2
				model = AccountTrainer.new
			when 3
				model = AccountGym.new
			else
			model = AccountUser.new
			end
			model['account_id'] = account.id
			model.save
			render :json => {success: "Sucessfully data saved"}  and return
		 else
			render :json => { errors: "Invalid email or password" } and return
		end
     end
   end

   def store

    issocial = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['isSocial']
    connection = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['connection']

    if issocial && connection == "fitbit"
			session[:oauth_token] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['access_token']
			session[:oauth_secret] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['access_token_secret']
			session[:uid] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['user_id']
			render :json => request.env['omniauth.auth'] and return
	end

    session[:fit_id] = request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['user_id']

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
				# chk if exist
				authorization = Authorization.find_by_provider_and_uid(session[:provider], session[:fit_id])
				if authorization
				   render :json => authorization and return
				else
				  user = Account.new :fit_id => session[:fit_id], :first_name => session[:first_name], :last_name => session[:last_name], :email => session[:email],:user_name => session[:user_name],:pic => session[:avatar]
				  user.authorization.build :provider => session[:provider], :uid => session[:fit_id]
				  user.save
				  account_user = AccountUser.new :account_id => user.id
				  account_user.save
				  render :json => account_user and return
				end
    else  # for other users
      user =  Account.find_by fit_id: session[:fit_id]
      session[:account] = request.env['omniauth.auth']['extra']['raw_info']
      if user.blank?
      account = Account.new
      account['fit_id'] = session[:fit_id]
      account['first_name'] = session[:account][:first_name]
      account['last_name'] = session[:account][:last_name]
      account['user_name'] = session[:account][:username]
      account['email'] = session[:account][:email]
      account['user_type'] = session[:account][:account_type].to_i
        if account.save
          case session[:account][:account_type].to_i
          when 2
            model = AccountTrainer.new
          when 3
            model = AccountGym.new
          else
           model = AccountUser.new
          end
          model['account_id'] = account.id
          model.save
            if session[:account][:account_type].to_i == 3
               render :json => { "user" => model, "location" => "about"} and return
            else
                render :json => model and return
            end
        else
          render :json => { errors: "Invalid email or password" } and return
        end
      else
         render :json => user and return
      end
   end

  end

   def destroy
    account = Account.find_by(auth_token: params[:id])
    #account.generate_authentication_token!
    account.save
    head 204
  end

end
