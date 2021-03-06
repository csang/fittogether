module ApplicationHelper

  def company_title(company_title)
		content_for :company_title, company_title.to_s
  end
  def title(page_title)
		content_for :title, page_title.to_s
  end
  def meta_keywords(meta_keywords)
    content_for :meta_keywords, meta_keywords.to_s
  end
  def meta_description(meta_description)
    content_for :meta_description, meta_description.to_s
  end


  def error_messages(curr_resource)
		return "" if curr_resource.errors.empty?
		messages = curr_resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
		sentence = I18n.t("errors.messages.not_saved",
      count: curr_resource.errors.count,
      resource: curr_resource.class.model_name.human.downcase)

		html = <<-HTML
		<div id="error_explanation" class="preferences_errorExplanation">
		  <h4>#{sentence}</h4>
		  <ul>#{messages}</ul>
		</div>
		HTML
		html.html_safe
	end

  # Sorting Helper Function
	def sortable(column, title = nil)
	  title ||= column.titleize
	  css_class = column == sort_column ? "current #{sort_direction}" : nil
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, params.merge({:search => params[:search], :sort => column, :direction => direction}), {:class => css_class}
	end
	
  # Active Menu
  def active_if(page_name)
    if params[:controller] == page_name
      "list-group-item active"
    else
      "list-group-item"
    end
  end
  
  def flash_class(level)
    case level
    when :notice then "alert alert-success"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-danger"
    end
  end
  
  def get_activity_name(id, field)
    activityName = Activity.where(:id => id).first
    return (activityName.present?) ?  activityName["#{field}"] : false ; 
  end
  
  
   
  def get_gym_name(id)
 
    gymName = AccountGym.where(:account_id => id).first
    return (gymName.present?) ?  gymName['name'] : 'N/A' ; 
  end
   
  def get_city_name(id)
    cityName = City.where(:id => id).first
    return (cityName.present?) ?  cityName['name'] : 'N/A' ; 
  end
  
  def get_state_code(id)
    stateCode = City.where(:id => id).first
    return (stateCode.present?) ?  stateCode['state_code'] : 'N/A' ; 
  end
  
  
   
  def get_state_name(code)
    stateName = State.where(:state_code => code).first
    return (stateName.present?) ?  stateName['name'] : false ; 
  end
   
  def get_goal_name(id)
    goalName = Goal.where(:id => id).first
    return (goalName.present?) ?  goalName['name'] : false ; 
  end
  def get_relationship_name(id)
    relName = Relationship.where(:id => id).first
    return (relName.present?) ?  relName['name'] : false ; 
  end
   
  def get_field_value(model,column, value)
    result = model.constantize.where(:id => value).first
    return (result.present?) ?  result[column] : false ;
  end
   
  def get_specialty_name(id)
    speName = Specialty.where(:id => id).first
    return (speName.present?) ?  speName['name'] : false ; 
  end
   
  def get_amenity_name(id)
    ameName = Amenity.where(:id => id).first
    return (ameName.present?) ?  ameName['name'] : false ; 
  end
   
  def get_user_name(id)
    gymName = AccountGym.where(:id => id).first
  
    if gymName.present?
      uName = Account.select('user_name').where(:id => gymName['account_id']).first
    end 
    return (uName.present?) ?  uName['user_name'] : 'N/A' ; 
  end
   
  def get_user_detail(id)
   
    userdetails =  Account.where(:id => id).first
      
    return userdetails;
	
  end 
   
  def check_if_friend(postuserid, loginuserid)
    
    @friend = Friendship.where(:account_id => postuserid , :friend_id =>loginuserid, :approved => true).first 
    if !@friend.present?
      @friend = Friendship.where(:account_id => loginuserid  , :friend_id =>loginuserid, :approved => true).first 
    end	
    return (@friend.present?) ?  true : false ; 
   
  end
   
  def useravatar(profileuser)
    #abort(profileuser.inspect)
    
    @privacy = nil 
  
    if !profileuser.account_privacy.nil?	
      if profileuser.account_privacy.account_id!=@account.id  
        privacy = profileuser.account_privacy 
      end 
    end 
	 	
    if !privacy.present?     
		if profileuser.avatar.present? 
         @img = profileuser.avatar(:thumb)
		elsif   profileuser.pic.present?  
			@img = 'https://' + profileuser.pic
	    else  
        @img = 'default.png'
	    end 	     		
    else    			  
		  if privacy.profile_pic.present? &&  privacy.profile_pic==true  
			if profileuser.avatar.present? 
			  @img = profileuser.avatar(:thumb)
			elsif   profileuser.pic.present?  
			  @img = 'https://' + profileuser.pic
			else 
			  @img = 'default.png'
			end 
		  else 
			@img = 'default.png'
		  end 				  
    end 	
    					 
    return @img
    
  end
   
  def messagecount
    @conversation =	Conversation.involving(@account.id).order("id DESC")
    conv = []
    @conversation.each do |abc|
      conv.push(abc.id)
    end
    
    cont = Message.where("account_id != ? && is_read = ? && conversation_id IN (?)" , @account.id, 0, conv).count
    return cont > 0 ? cont : ''
  end
  
  def get_conversation_id(frnd_id)
    
      @conversation = Conversation.between(@account.id,frnd_id).first
    if !@conversation.present?
    return
    end  
    return  @conversation.id.present? ? Base64.encode64(@conversation.id.to_s) : '';
    
  end
  
  def get_simp_conv_id(frnd_id)
    
     @conversation = Conversation.between(@account.id,frnd_id).first
    if !@conversation.present?
    return
    end  
    return  @conversation.id.present? ? @conversation.id : '';
    
  end
  
  def get_firstname_of_members(id)

    cm = ConversationMember.where(:conversation_id => id)
    account_ids = cm.map(&:account_id)
    acc_name = Account.select(:first_name).where(:id =>account_ids)
    return acc_name.map(&:first_name).join(', ')
  end
  
  def get_user_array(account)
  
     if account.present?          
         acc = {}		      
		 acc[:id] = account.id.to_s		     						
		 acc[:first_name] = account.first_name
		 acc[:last_name] = account.last_name
		 acc[:user_name] = account.user_name
		 acc[:pic] = account.pic
		 acc[:avatar] = account.avatar		
		 acc[:user_type] = account.user_type		
		  return acc
	 end	 	
    
  end
  
  def get_friend_and_member(profileuser, goings = nil)
 
  user = Array.new  
	 if profileuser.passive_friends.present? 
        profileuser.passive_friends.each do |member|
      
        if goings.present?
			if  !goings.include? member.id  
			 user.push(member)
			end
        else 
        user.push(member)
        end
     
         if member.account_privacy.present? 
			 if member.account_privacy.account_id!= current_user.id  
			  privacy = {}			     						
			  privacy[:privacy] = member.account_privacy 
			  user.push(privacy)
			end 
		 end 
       end 
     end 
     
      if profileuser.active_friends.present? 
         profileuser.active_friends.each do |member|
         if goings.present?
         if  !goings.include? member.id  
         user.push(member)
         end
         else 
         user.push(member)
         end
         if member.account_privacy.present? 
			 if member.account_privacy.account_id!= current_user.id 
			  privacy = {}			     						
			  privacy[:privacy] = member.account_privacy 
			  user.push(privacy)
			 end 
		 end 
       end 
     end 
  
   return user
  end
  
  def suggested_fitspot
    if @account.user_location.present?
    
    fitspots = Fitspot.where('account_id != ? && (location LIKE ? OR location LIKE ? OR location LIKE ? )', @account.id, "%#{@account.user_location}","%#{@account.user_location.split.last}","%#{@account.user_location.split.first}").order(" id Desc").limit(3)
    else
	fitspots = Fitspot.where('account_id != ?', @account.id).order("id Desc").limit(3)
	end
	return fitspots
  end
  
   def suggested_trainer  
     friend = friendship(@account)
	trainer = Account.where('id != ? AND user_type =? and id NOT IN (?)', @account.id,2,friend).limit(3)
	return trainer
  end
  
  def event_invitation # return event invitation to user
   event = EventAttender.where(:account_id => @account.id,:status => false).joins(:event).where("Date(event_date) >= ?",Date.today).limit(3)
   return event
  end
  
  def event_attending_new # return event attending to user
   event = EventAttender.where(:account_id => @account.id,:status => true).joins(:event).where("Date(event_date) >= ?",Date.today).limit(3)
   return event
  end
  
  	def eff_event_invitation # return event  suggested
  	#abort(@account.user_location.inspect)
	
	if @account.user_location.present?
		event = Event.joins(:event_attender, :fitspot).where("Date(event_date) >= ? AND events.account_id != ? AND event_attenders.event_id NOT IN (?) AND fitspots.location LIKE ? ",Date.today, @account.id, EventAttender.where(:account_id =>@account.id).map(&:event_id), "%#{@account.user_location}%").group("events.id").limit(3)
	else
		event = Event.joins(:event_attender, :fitspot).where("Date(event_date) >= ? AND events.account_id != ? AND event_attenders.event_id NOT IN (?) ",Date.today, @account.id, EventAttender.where(:account_id =>@account.id).map(&:event_id)).group("events.id").limit(3)
	end
		return event
   end
  
  # get trainer as method name suggested 
    def my_trainer_or_gym(profileuser, type)  
 
     if profileuser.active_friends.present?    
		 profileuser.active_friends.each do |ac|
			#abort(ac.user_type.inspect)
			if ac.user_type == type
			@ac = ac
			end
	 	end
	 else
		 if profileuser.passive_friends.present?	 
			profileuser.passive_friends.each do |ac|			 
				if ac.user_type == type
				@ac = ac
				end
			end
		 end	
	  end	 
	  @ac.present? ? @ac : nil
  end
  
  def my_favorite_fitspot(id)
  
   fitspot = FitspotMember.where(:account_id => id)
   return fitspot
  
  end
  
  def get_gym_trainors(account = nil)

    account = account.present? ? account : @account 
	active_trainer = []
	passive_trainer =[]
	if account.active_friends.present?    
		 account.active_friends.each do |ac|		
			if ac.user_type == 2 # 2 for trainer
			active_trainer.push(ac)
			end
	 	end
	end
	
	if account.passive_friends.present?    
		 account.passive_friends.each do |pc|		
			if pc.user_type == 2 # 2 for trainer
			passive_trainer.push(pc)
			end
	 	end
	end
	
	trainers = active_trainer + passive_trainer
	return trainers
  
  end
  
  def check_class_attendance(gym_class_id)
	 attend = ClassAttendance.where(:gym_class_id => gym_class_id, :account_id => @account.id ).first
     return  (attend.present?) ? true : nil
  end
  
  def get_booked_class_count(gym_class_id)
	 attend = ClassAttendance.where(:gym_class_id => gym_class_id).count
     return  (attend.present?) ? attend : 0
  end
  
  def get_trainer_class (id)
  
	gym_class = GymClass.where("trainer_id = ? AND  Date(class_date) = ?", id, Date.today).first
    return  (gym_class.present?) ? gym_class.specialty.name : 'N/a'
  end
  
  
  def new_friends_and_members
	
		
			 user = Array.new  
			 if @account.passive_friends.present? 
				@account.passive_friends.each do |member|			 
					  user.push(member)			 
				 if member.account_privacy.present? 
					 if member.account_privacy.account_id!= @account.id  
					  privacy = {}			     						
					  privacy[:privacy] = member.account_privacy 
					  user.push(privacy)
					end 
				 end 
			   end 
			 end 
			
			  if @account.active_friends.present? 
				 @account.active_friends.each do |member|
				   user.push(member)				 
				 if member.account_privacy.present? 
					 if member.account_privacy.account_id!= @account.id 
					  privacy = {}			     						
					  privacy[:privacy] = member.account_privacy 
					  user.push(privacy)
					 end 
				 end 
				end 
				end 
		
		     users = Array.new  						
			 user.each do |usr|
			     if usr.present? && usr[:first_name]!=nil
					 hash = {}	
					 hash[:full_name] = usr[:first_name].capitalize.to_s + ' ' + ( usr[:last_name].present? ? usr[:last_name].to_s : '')
					 hash[:initials] =  usr[:first_name]
					 hash[:user_name] =  usr[:user_name]	
				
					 if usr.avatar.present? 					
						img = usr.avatar(:thumb)
					 elsif   usr[:pic].present?  
						img = 'https://' + usr[:pic]
					 else  
						img = 'default.png'
					 end 
					 hash[:avatar] =    img
					 users.push(hash)
				 end 
		     end	
		  return  users.to_json
		
	end
	
	def get_fitbit(id)	
	fit = Fitbit.where(:account_id => id).first	
	return fit    
    end
    
    def get_sidebar_classes (id)
    
    	@gym_class = GymClass.where("account_id = ? AND  Date(class_date) = ?", id, Date.today).limit(5)
    
    end
    
    
    def get_groups			
	 groups = Group.all				
	 groups_array = Array.new  						
	 groups.each do |group|
	 
		 if groups.present? 
			 hash = {}	
			 hash[:full_name] = group[:title].capitalize
			 hash[:initials] =  group[:title][0]
			 hash[:id] =  group[:id]
			 hash[:avatar] =  group.group_image.present? ? group.group_image(:thumb) : '/assets/group.jpg'	
			 groups_array.push(hash)
		 end 
	 end	
     return  groups_array.to_json		
	end
	
	 def check_event_kudos(id)
      kudos =  EventKudo.where(:account_id => @account.id, :event_id =>id).first 
      if kudos.present?
        return 'icon-liked'
      else
        return 'icon'
      end
    
  end
  
  def friendship(profileuser)
	
  af = []
  pf = []
	if profileuser.passive_friends.present? 
	   pf = profileuser.passive_friends.map(&:id)
	end
	if profileuser.active_friends.present? 
		af=  profileuser.active_friends.map(&:id)
	end
	friend = pf
	if !pf.nil? && !af.nil?  
	 friend = pf + af 
	elsif !af.nil? 
	 friend = af 
	end   
  
  end
  
  def pending_friendship(profileuser)
	
  af = []
  pf = []
	if profileuser.pending_friends.present? 
	   pf = profileuser.pending_friends.map(&:id)
	end
	if profileuser.requested_friendships.present? 
		af=  profileuser.pending_friends.map(&:id)
	end
	friend = pf
	if !pf.nil? && !af.nil?  
	 friend = pf + af 
	elsif !af.nil? 
	 friend = af 
	end   
  
  end
  
  def get_friend_and_attender(profileuser, goings = nil) 
    friend = friendship(profileuser)   
    common_ids = goings & friend
    return  Account.where(:id => common_ids) # return user's friends that are  attending event 
   end
  
	def check_if_event_attender(event_attender) #to check if current user attending an event
		  if !event_attender.present? 
			return false
		  end
		  id = event_attender.map(&:account_id)         
		  usr = id.include? @account.id ? @account.id : nil 
		  return usr.present? ? true : false   
	 end
	 
	 def suggested_friend(profileuser,limit)
	 	 friend = friendship(profileuser)
	 	 pending_friend = pending_friendship(profileuser)	  
	 	 friend = friend + pending_friend
		
        frnd = Friendship.find_by_sql("SELECT friend_id FROM friendships WHERE account_id IN (SELECT friend_id FROM friendships WHERE account_id=#{@account.id}) ").map(&:friend_id)   
        accnt = Friendship.find_by_sql("SELECT account_id FROM friendships WHERE friend_id IN (SELECT account_id FROM friendships WHERE account_id=#{@account.id}) ").map(&:account_id)
        ids = frnd + accnt     
        ids = ids - friend
        friend.push(@account.id)    
      
        if ids.present?       
			user =  Account.where("id IN (?) && user_type != ? && user_type != ?" , ids, 2, 3).limit(limit)
			if user.present?
				return user
			else
			    if profileuser.user_location.present?
			  		return Account.where("id NOT IN (?) && user_type != ? && user_type != ? && (user_location LIKE ? OR user_location LIKE ? OR user_location LIKE ? )", friend,2,3, "%#{profileuser.user_location}","%#{profileuser.user_location.split.last}","%#{profileuser.user_location.split.first}").limit(limit)
				else
					return Account.where("id NOT IN (?) && user_type != ? && user_type != ?", friend,2,3).limit(limit)
				end
			end			
        else              
			return Account.where("id NOT IN (?) && user_type != ? && user_type != ?", friend,2,3).limit(limit)
        end
	 
	 end
	 
	 def my_gym
		if @account.gym_id.present?		  
		   gym =  AccountGym.find_by_id(@account.gym_id)
		   if gym.present?
		   user = Account.select('user_name').where(:id => gym.account_id).first
		   return user.present? ? user.user_name : ""
		   end
	   else
	    return "about"
	   end 
	
	 end
	 
	 def my_trainer
	   friend = friendship(@account)
	   if friend.present?
		 my_trainer = Account.where(:id =>friend, :user_type =>2).last
		 if my_trainer.present?
			return my_trainer.user_name
		 end
	   end
	   
	 end
	 
	 def fitspot_location(id)
		place = Fitspot.select("location").where(:id => id).first
		return place.present? ? place.location : ""
	 end
	 

  
    def get_gym_checkin(user_id, id) #count checkin gym 
		return Checkin.where(:account_id => user_id, :account_gym_id => id).count 
    end
    
    def get_gym_trainors_from_settings(gym_id)
    
    trainers =  AccountTrainer.where(:gym_id => gym_id )
      account_ids =  trainers.present? ? trainers.map(&:account_id) : nil
    return Account.where(:id => account_ids)
    
    end
  
	 
	 
  end
  

     
