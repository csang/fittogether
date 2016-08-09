module FeedHelper
  
  def tag_links(tag)
    link_to tag.strip, tag_path(tag.tr('#', '')) 
  end

  def is_number?(obj)
    obj.to_s == obj.to_i.to_s
  end
    
  def user_links(id)
    
    newid =  Base64.decode64(id)
    if is_number?(newid)
      user =  Account.find(newid) 
      if user.present?
        last =  user.last_name.present? ? user.last_name.to_s : ''  
        name = user.first_name + ' ' + last
        link_to name , profile_path(user.user_name) 
      end
    else 
      id
    end
  
  end
  
  def full_name(id)
    newid =  Base64.decode64(id)
    if is_number?(newid)
      user =  Account.find(newid) 
      if user.present?
        last =  user.last_name.present? ? user.last_name.to_s : ''  
        fullname = user.first_name + ' ' + last
        return fullname
      end 
    end
    
  end
  
  def check_kudos(id)
      kudos =  Kudo.where(:account_id => @account.id, :post_id =>id).first 
      if kudos.present?
        return 'icon-liked'
      else
        return 'icon'
      end
    
  end
  
  def set_fitbit(activities)
	
    if activities.present?    
      activities['goals']['caloriesOut']
	  activities['summary']['caloriesOut']
	  activities['goals']['steps']
	  activities['goals']['distance']
      @fit = Fitbit.where(:account_id => @account.id).first

		  if !@fit.present?
			 Fitbit.create(:account_id => @account.id, :steps =>activities['goals']['steps'], :calories =>activities['goals']['caloriesOut'], :distance =>activities['goals']['distance'], :summary_calories =>activities['summary']['caloriesOut'])
			  
			  if Post.create(:account_id=>@account.id,:text=>'Fitbit', :status=>1,:share_with=> 'Public',:post_type=> 'fitbit')
				puts "done"
			  else
			  	puts "error"
			  end
			 else       
			 @fit.update_attributes(:steps =>activities['goals']['steps'], :calories =>activities['goals']['caloriesOut'], :distance =>activities['goals']['distance'], :summary_calories =>activities['summary']['caloriesOut'])
			if  Post.create(:account_id=>@account.id,:text=>'Fitbit', :status=>1,:share_with=> 'Public',:post_type=> 'fitbit')
			   puts "done"
			else
			   puts "error"
			end
		  end  
  end
  end
  
  def fitb(user, date) #get activities form fitbit 
   activity_objects = []
  # abort(user.inspect)
   if user.present? && user.oauth_token.present? 
      activities = user.fitbit_data.daily_activity_summary("today")     
      activity_objects = activities
    end
   set_fitbit(activity_objects)
  
  end

 
end
