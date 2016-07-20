
class Api::V1::SettingsController < Api::V1::BaseController
 before_action :authenticate_with_token!, only: [:update_privacy, :update_social_settings]

  # privacy settings
   def privacy
    user_privacy = AccountPrivacy.where(:account_id=>current_user.id).first
    privacies = Privacy.all()    
	render :json => {'privacies' => privacies, 'user_privacy' => user_privacy}
  end
	
	# update privacy settings
	
  def update_privacy

    privacy = AccountPrivacy.where(:account_id=>current_user.id).first
    if privacy.present?     	
      #~ if privacy.update_attributes(:profile_pic => params[:profile_pic], :email => params[:email],:mobile => params[:mobile],:birthday => params[:birthday],:work => params[:work],:location => params[:location],:bio => params[:bio])	
      if privacy.update_attributes(privacy_params)	
   		 render :json => AccountPrivacy.find_by_id(privacy.id)
      else
		 render :json => {errors: "Please Try again"} 
      end
    else
      privace =  AccountPrivacy.create(privacy_params.merge(:account_id=>current_user.id))	
      if privace.present?
		render :json => privace
      else
		render :json => 0
      end
    end
    
    
  end
  
  # update social settings
  
  def update_social_settings
 
   result = Account.where(:id=>current_user.id).first	
    if request.post?
      if result.update_attributes(params.permit(:fb_link, :tw_link, :google_link, :linked_link)) 
       result = Account.where(:id=>current_user.id).first
      end
		if current_user.user_type.present? && current_user.user_type.to_i == 2
		  exit = AccountTrainer.where(:account_id=>current_user.id).first 
		  if exit.present?
		   if exit.update_attributes( params.permit(:gym_id, :fitness_discpline,:certs,:awards,:personal_training,:age,:bootcamp,:location_bootcamp,:affiliate,:url,:train_user_type,:home_training))
		     exit = AccountTrainer.where(:account_id=>current_user.id).first 
		   end
		  end
		end
    end
    if result
      render :json => {'account' => result, 'trainer' => exit}
    else
      render :json => 0
    end
    
  end  
  
  # show about
  	def show_about_settings
  
    model = (params[:account_type].to_i == 2) ? AccountTrainer : params[:account_type].to_i == 3 ? AccountGym : AccountUser
    account_details = model.where(:account_id=>params[:account_id]).first 
    
    render :json => account_details and return

	end
	
	# update about from simple user 
	
	def update_about_settings
	
	  if request.post?
		  belong = params[:belong]=="y" ? 1 :0
		   acc = Account.find(current_user.id)	
		  
		  #~ result = acc.update_attributes(:gender => params[:gender],:gym_id => params[:gym],
		  #~ :gym_location_id => params[:location], :industry_id => params[:industry], :profession_id => params[:profession], :relationship_id => params[:relationship],
		  #~ :dob => params[:date][:year]+'-'+params[:date][:month]+'-'+params[:date][:day],:zipcode=>params[:zipcode],:company => params[:company],:reason_id => params[:reason],:goals => params[:goal],:belong => belong)
		  	
		  result = acc.update_attributes(:gender => params[:gender],:gym_id => params[:gym], :industry_id => params[:industry], :profession_id => params[:profession], :relationship_id => params[:relationship], :zipcode=>params[:zipcode],:company => params[:company],:reason_id => params[:reason],:goals => params[:goal], :belong => belong, :dob => params[:birth_format], :user_location => params[:user_location])	
		
			
				#abort(result.errors.inspect)
		  if params['trainer_contacts'].present?
		  account_details = AccountUser.where(:account_id=>params[:account_id]).first
		  result_detail =  account_details.update_attributes(:trainer_contacts => params[:trainer_contacts])  
		  end
			 if result
			  render :json => 1
			 else
			  render :json => 0
			 end
	 else		
      render :json => 'request type not available'    
     end
	
	end

   def update_about_gym
	  if request.post?		
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
		  user_address = params[:address].split(",")
		  
		  account_details = AccountGym.where(:account_id=>current_user.id).first
		  #~ res = account_details.update_attributes(:name => params[:name], :address =>user_address, :specialties => params[:specialty], :franchise => params[:franchise], :groupclasses => params[:groupclasses], :dancetypes => params[:dancetype], :train_client_at_your_gym => params[:train_client_at_your_gym], :fee => params[:fee], :amenities => params[:amenity], :timings => timing)
		  res = account_details.update_attributes(:name => params[:name], :address =>user_address, :specialties => params[:specialty], :franchise => params[:franchise], :groupclasses => params[:groupclasses], :train_client_at_your_gym => params[:train_client_at_your_gym], :amenities => params[:amenity], :timings => timing)
			 if res
			   render :json => 1
			  else 
			   render :json => 0
			  end
	  else		
       render :json => 'request type not available'    
      end
	  end
  
  # some fields only related to trainers
  def update_about_trainers
  
    if request.post?	 
      account_details = AccountTrainer.where(:account_id=>params[:account_id]).first
      if account_details.update_attributes(:certificates => [params[:certificates]], :workout_tips => [params[:workout_tips]])
        render :json => 1
      else 
        render :json => 0
      end
    else
        render :json => 'request type not available'  
    end
  
  end
  
  # update profile pic
  	def update_avatar
	
		acc = Account.find(current_user.id)
		acc.avatar = params[:avatar]
		unless acc.valid?
			abort(acc.errors.inspect)
		end
		if acc.save	
			 render :json => 1
		else
			 render :json => 0
		end

	end
  #basic info update
  def update_profile	
    acc = Account.find(params[:account_id])	
    if params[:mobile].present?
      params[:mobile] = params[:mobile][0] == nil ? params[:mobile][0] + params[:mobile][1] + params[:mobile][2] : params[:mobile]
    else 
      params[:mobile] = ''
    end
    if acc.update_attributes(params.permit(:first_name, :last_name, :user_name, :account_url, :mobile))
    
      render :json => 1
    else 
      render :json => 0
    end
  
  end
  
    #update activity
   def get_update_activity
   
   user_activities = AccountActivity.where(:account_id=>current_user.id).first	
   if request.post? 
		if user_activities.present?
		  ap = AccountActivity.find(user_activities.id)	
		  if ap.update_attributes(:activity_id => params[:activity])	
		      user_activities = AccountActivity.where(:account_id=>current_user.id).first	
		  else
		     render :json => 'Please Try Again' and return
		  end
		else
		  user_activities = AccountActivity.create(:account_id=>current_user.id,:activity_id => params[:activity])	
		end
		if user_activities
		   render :json => user_activities and return
		else 
		  render :json => 0 and return
		end
  else
   if !user_activities.present?
    render :json => 0 and return
   end
  end 
   render :json => user_activities and return
  end
  
  # update email settings
  
    def update_email_settings
	
    exist = AccountEmailSetting.where(:account_id=>current_user.id).first
    if exist.present?
      ap = AccountEmailSetting.find(exist.id)	
      result = ap.update_attributes(email_setting_param)	
    else
      result = AccountEmailSetting.create(email_setting_param.merge(:account_id=>current_user.id))	
    end
    if result
     render :json => result and return
    else 
     render :json => result.errors and return 
    end  
   
  end
 
  
  
  # get all email settings
   def email_notification_settings
   user_email = AccountEmailSetting.where(:account_id=>current_user.id).first	
     email_settings = EmailSetting.all()
		if user_email.present?
			render :json => {'email_settings' => email_settings, 'user_email' => user_email} and return
		else  
			if email_settings.present?
			render :json => {'email_settings' => email_settings} and return
			
			else
				render :json => 0 and return
			end
		end
	end
	
	# get activiy 
	
	
	def activities
	user_activities = AccountActivity.where(:account_id=>current_user.id).first	
	activities = Activity.all()
	if user_activities.present?
		render :json => {'activity_id' => user_activities['activity_id'], 'activities' => activities} and return 
	else
			if activities.present?
			render :json => {'activities' => activities} and return
			else
				render :json => 0 and return
			end
		end
	end
	def get_about_options
		result = Account.where(:id=>current_user.id).first
		industries = Industry.all()
		professions = Profession.all()
		relationship = Relationship.all()
		goal = Goal.all()
		
		reason = Reason.all()
		render :json => {'industries' => industries, 'professions' => professions, 'relationship' => relationship, 'goal'=> goal, 'reason' => reason, 'account' =>  result} and return
		
	end 
 
	def get_about_gym_option
	account_gym = AccountGym.where(:account_id=>current_user.id).first
	 specialty = Specialty.all()
	 amenity = Amenity.all()
	render :json => {'specialty' => specialty, 'amenity' => amenity, 'account_gym' =>  account_gym} and return
	end
	
	
	def get_main_gym
		user_gym = AccountTrainer.where(:account_id=>current_user.id).first
		account = Account.where(:id=>current_user.id).first
		account_gym = AccountGym.all()
		if current_user.user_type.present? && current_user.user_type.to_i == 2
			render :json => {'account_gym' =>  account_gym, 'user_gym' => user_gym, 'account' => account} and return
		else
			render :json => {'account_gym' =>  account_gym, 'account' => account} and return
		end 
	end
	
	#Get update_crop avatar 
	def update_crop	
		@account = Account.where(:id=>current_user.id).first
		if @account.update_attributes(:crop_x => params[:crop_x], :crop_y =>params[:crop_y],:crop_w =>params[:crop_w],:crop_h =>params[:crop_h])
		@account.reprocess_avatar
			 render :json => 1
		else
			render :json => 0
		end
	end
	 
	# chk user name already exist
	
	def check_user_data 
	account = Account.where(:user_name =>  params[:username]).first
     if Account.where(:user_name =>  params[:username]).present?
		if account.id!= current_user.id
			result = 1
        else 
			  result = 0
        end
      else
        result = 0
      end 
      render :json => result and return
      
   
   end
	
  private
  
  def email_setting_param    
     params.permit(:new_rating, :new_appointment_request, :new_review, :appointment_approve, :group_invitation, :mentioned_in,:comment_on_post)
  end
  
  def privacy_params
 
  	params.permit(:profile_pic, :email, :mobile, :birthday, :work, :location, :bio)	
  end

 def crop_params
    params.permit(:crop_x, :crop_y, :crop_w, :crop_h)
  end


 
end #end of class


