class SettingsController < ApplicationController
    
	before_action :get_account
	helper_method :isprivate
	helper_method :is_email, :is_visible
	
  def index    
    @page = 'settings_basic'
  end

  def settings
    
		@page = 'settings_basic'
	end

	def basic
		@page = 'settings_basic'
		render 'index'
	end

	def about
    @cities = City.all()
    model = (@account_type.to_i == 2) ? AccountTrainer : AccountUser
    @account_details = model.where(:account_id=>@account.id).first 
	 
	if @account_type == "3"
      @account_gyms = AccountGym.where(:account_id=>@account.id).first 
    end
    #abort(@account_gyms.inspect) 
		@page = 'settings_about'
		render 'index'
	end

	def activities
		@activities = Activity.all();
		@accactivity = AccountActivity.where(:account_id=>@account.id).select('activity_id').first
		@page = 'settings_activities'
		render 'index'
	end

	def privacy
    @privacies = Privacy.all();	    
		@page = 'settings_privacy'
		render 'index'
	end

	def social_settings
    @account_details = Account.where(:id=>@account.id).first
    if @account_type.to_i == 2
      @account_trainers = AccountTrainer.where(:account_id=>@account.id).first 
   else
      @account_users= AccountUser.where(:account_id=>@account.id).first 
    end
  	
    if @account_trainers.blank?
      @account_trainers = AccountTrainer.new
    end
	
		@page = 'settings_social_settings'
		render 'index'
	end

	def fitbit
		@page = 'settings_fitbit'
		render 'index'
	end

	def support
		@page = 'settings_support'
		render 'index'
	end
  
  def email_notification_settings
     @email_settings = EmailSetting.all()
  
		@page = 'settings_email'
		render 'index'
	end
	
	def update_avatar
    #abort(@account.inspect)
    @acc = Account.find(@account.id)
    @acc.update_attribute(:avatar, params[:avatar])	
    flash[:notice] = "Avatar has been updated successfully."
    redirect_to request.env['HTTP_REFERER'] and return
  end
  
  def update_profile	
    @acc = Account.find(@account.id)	
    if params[:mobile].present?
      mobile = params[:mobile][0] + params[:mobile][1] + params[:mobile][2]
    else 
      mobile = ''
    end
    if @acc.update_attributes(:first_name => params[:fname],:last_name => params[:lname],:user_name => params[:username],:account_url => params[:url],:mobile => mobile)	
      flash[:notice] = "User profile has been updated successfully."
    else 
      flash[:error] = "User profile could not be updated. Please try again."
    end
    redirect_to request.env['HTTP_REFERER'] and return
  end
  
  def update_privacy
	
    @exist = AccountPrivacy.where(:account_id=>@account.id).first
    if @exist.present?
      @ap = AccountPrivacy.find(@exist.id)	
      @ap.update_attributes(:profile_pic => params[:profile_pic],:email => params[:email],:mobile => params[:mobile],:birthday => params[:birthday],:work => params[:work],:location => params[:location],:bio => params[:bio])	
    else
      AccountPrivacy.create(:account_id=>@account.id,:profile_pic => params[:profile_pic],:email => params[:email],:mobile => params[:mobile],:birthday => params[:birthday],:work => params[:work],:location => params[:location],:bio => params[:bio])	
    end
    flash[:notice] = "Privacy settings has been updated successfully."
    redirect_to request.env['HTTP_REFERER'] and return
  end
  
  def isprivate(slug)
    pre = AccountPrivacy.where(:account_id=>@account.id)
    if !pre.present?
     return 123 
    else
		ip = AccountPrivacy.where(:account_id=>@account.id).select(slug).first
		if ip.present? 
		  return ip[slug]
		  else 
		  return false
		  end	
	end	  
      
  end
  
  def update_activity
    #	abort(params.inspect)
    @exist = AccountActivity.where(:account_id=>@account.id).first
	
    if @exist.present?
      @ap = AccountActivity.find(@exist.id)	
      @ap.update_attributes(:activity_id => params[:activity])	
    else
      AccountActivity.create(:account_id=>@account.id,:activity_id => params[:activity])	
    end
    flash[:notice] = "Activities settings has been updated successfully."
    redirect_to request.env['HTTP_REFERER'] and return
  end
  
  def update_about
    belong = params[:belong]=="y" ? 1 :0
    @acc = Account.find(@account.id)	
    result = @acc.update_attributes(:gender => params[:gender],:city_id => params[:city_id_0],:state_id => params[:state_id_0],:gym_id => params[:gym],
      :gym_location_id => params[:location], :industry_id => params[:industry], :profession_id => params[:profession], :relationship_id => params[:relationship],
      :dob => params[:date][:year]+'-'+params[:date][:month]+'-'+params[:date][:day],:zipcode=>params[:zipcode],:company => params[:company],:reason_id => params[:reason],:goals => params[:goal],:belong => belong)	
	  if params['trainer_contacts'].present?
      @account_details = AccountUser.where(:account_id=>@account.id).first
      result_detail =  @account_details.update_attributes(:trainer_contacts => params[:trainer_contacts])  
    end
    if (result || result_detail )
        flash[:notice] = "About settings has been updated successfully."
    else 
        flash[:error] = "User\'s About settings could not be updated. Please try again."
    end
    

    redirect_to request.env['HTTP_REFERER'] and return
  end
  
  def update_social_settings
 
    if !params['account'].nil?
      @account_details = Account.where(:id=>@account.id).first
      result = @account_details.update_attributes(params.require(:account).permit(:fb_link, :tw_link, :google_link, :linked_link)) 
    end
    if @account_type.to_i == 2
      @exist = AccountTrainer.where(:account_id=>@account.id).first 
      if @exist.present?
      result =  @exist.update_attributes( params.require(:account_trainers).permit(:gym_id, :fitness_discpline,:certs,:awards,:personal_training,:age,:bootcamp,:location_bootcamp,:group_training,:affiliate,:url,:train_user_type,:home_training))
      end
    end
    if result
      flash[:notice] = "Social settings has been updated successfully."
    end
    redirect_to request.env['HTTP_REFERER']
  end  
  
  def update_trainers_details
  
    if params[:account_trainers].present?
      # abort(params[:account_trainers][:certificates].is_a?(Array).inspect)
      @account_details = AccountTrainer.where(:account_id=>@account.id).first
      if @account_details.update_attributes(:certificates => params[:account_trainers][:certificates], :workout_tips => params[:account_trainers][:workout_tips])
        flash[:notice] = "About settings has been updated successfully."
      else 
        flash[:error] = "About settings cannot be updated. Please try again"
      end
    end
    
    redirect_to request.env['HTTP_REFERER'] and return
  end
  
  def check_user_data 
    if request.xhr?
      if Account.where(:user_name => params[:username]).present?
        result = 'success'
      else
        result = 'error'
      end 
			render :json => {
        :data => result
      }
    end
    # render nothing: true 
  end
  
  def update_about_gym
 # abort(@account.id.inspect)
  timing = Hash.new
  timing['sunday_start'] =params[:sunday_start] 
  timing['sunday_end'] =params[:sunday_end] 
  timing['monday_start'] =params[:monday_start] 
  timing['monday_end'] =params[:monday_end] 
  timing['tuesday_start'] =params[:tuesday_start] 
  timing['tuesday_end'] =params[:tuesday_end] 
  timing['wednesday_start'] =params[:wednesday_start] 
  timing['wednesday_end'] =params[:wednesday_end] 
  timing['thrusday_start'] =params[:thrusday_start] 
  timing['thrusday_end'] =params[:thrusday_end]
  timing['friday_start'] =params[:friday_start] 
  timing['friday_end'] =params[:friday_end]
  timing['saturday_start'] =params[:saturday_start] 
  timing['saturday_end'] =params[:saturday_end]
  
  @account_details = AccountGym.where(:account_id=>@account.id).first
  @res = @account_details.update_attributes(:name => params[:name], :address =>params[:address], :specialties => params[:specialty], :franchise => params[:franchise], :groupclasses => params[:groupclasses], :dancetypes => params[:dancetype], :train_client_at_your_gym => params[:train_client_at_your_gym], :fee => params[:fee], :amenities => params[:amenity], :timings => timing)
    if @res
     flash[:notice] = "About settings has been updated successfully."
      else 
        flash[:error] = "About settings cannot be updated. Please try again"
      end
   redirect_to request.env['HTTP_REFERER'] and return
  end
  
  def get_gym_address
   
    
     if request.xhr?
     gyddata = AccountGym.select('address').where(:id =>params[:id]).first 
      
     if gyddata.present?
        addres = '<option value="">Location</option>'
        x = 1
       gyddata.address.each { |y| 
        addres += "<option value='#{x}'>#{y} </option>"
        x += 1
       }
        	render :text =>  addres
   
      else
        result = 'error'
      end 
		
    end
              
    
  end
  
    def is_email(slug)
    pre = AccountEmailSetting.where(:account_id=>@account.id)
    if !pre.present?
     return 123 
    else
		ip = AccountEmailSetting.where(:account_id=>@account.id).select(slug).first
		if ip.present? 
		  return ip[slug]
		  else 
		  return false
		  end	
	end	  
      
  end
  
    def is_visible(slug)
      
      if slug == 'new_rating' && @account.user_type!=2
        return 'invisible'
      elsif slug == 'new_appointment_request' && @account.user_type!=2
        return 'invisible'  
       elsif slug == 'new_review' && @account.user_type!=3
        return 'invisible'    
      end
      
      end
    
  
    
  def update_email_settings
	
    @exist = AccountEmailSetting.where(:account_id=>@account.id).first
    if @exist.present?
      @ap = AccountEmailSetting.find(@exist.id)	
      @ap.update_attributes(email_setting_param)	
    else
      AccountEmailSetting.create(email_setting_param.merge(:account_id=>@account.id))	
    end
    flash[:notice] = "Email settings has been updated successfully."
    redirect_to request.env['HTTP_REFERER'] and return
  end
  
  
  private
  
  def email_setting_param
    
     params.permit(:new_rating, :new_appointment_request, :new_review, :appointment_approve, :group_invitation, :mentioned_in,:comment_on_post)
  end

end
