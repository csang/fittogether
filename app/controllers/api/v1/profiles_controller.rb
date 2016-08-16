class Api::V1::ProfilesController < Api::V1::BaseController

	before_action :authenticate_with_token!, except: :about
	before_action :profile_user, except: :search_all
    include ApplicationHelper
      #index method 
	  def index
        # get post to show on fitfeed tab	  
     
        if @friend.present? && @friend.approved ==true
        	posts = Post.where("status = ? AND account_id = ? AND share_with != ?   ",1, @profileuser.id, "Private").order("id DESC")
        elsif @profileuser.id == current_user.id
            posts = Post.where(:status=>1, :account_id => @profileuser.id).order("id DESC")	
        else            
		    posts = Post.where("status = ? AND account_id = ? AND share_with = ?", 1, @profileuser.id, "Public").order("id DESC")
        end
         all_post = Array.new        
	     posts.each do |post|
	     hash = {}          						
		 hash[:post] = post			
		 hash[:comment] = {}			
	           if post.comment.present?	          
				post.comment.each do |come|
				  hash[:comment][come.id] = come					
				end				
		      end	
		     all_post.push(hash)  	
	     end
	    # abort(all_post.inspect)
	    render :json => {'post' => all_post, 'friend' => @friend, 'profile_user' => @profileuser}
		
	 end # end of index
   
	# display about information in about tab
	#params username as id, and account _id
	def about
	
    allchalenge = Challenge.where("challenges.account_id =? OR challenges.to_id =? AND(sender_status=?) ", @profileuser.id,@profileuser.id,1).count
    chal = Challenge.where("challenges.valid_till < ? AND (challenges.account_id =? OR challenges.to_id =? ) ", Date.today, @profileuser.id,@profileuser.id).count
    echal = Challenge.where("(status =? and challenges.account_id!=?) AND (challenges.account_id =? OR challenges.to_id =? ) and challenges.valid_till > ? ", 'reject', @profileuser.id, @profileuser.id,@profileuser.id, Date.today).count
	chal = chal + echal
	
	challange = Hash.new
	challange['allchalenge'] = allchalenge
	challange['chal'] = chal
	challange['expirechal'] = echal
	
    if (@profileuser.user_type.to_i == 2) 
      details= AccountTrainer.where(:account_id => @profileuser.id).first
    elsif (@profileuser.user_type.to_i == 3) 
      details = AccountGym.where(:account_id => @profileuser.id).first
    else
      details = AccountUser.where(:account_id => @profileuser.id).first
    end
    privacy = nil
    if @profileuser.account_privacy.present? 
	 if @profileuser.account_privacy.account_id!=params[:account_id]
	    privacy = @profileuser.account_privacy 
	 end  
	end  
	fitbit = nil
	if @profileuser.fitbit.present?
		fitbit = @profileuser.fitbit 
    end		
     
	render :json => {'challange' => challange, 'about' => details, 'profile_user' => @profileuser, 'privacy' => privacy, 'fitbit' =>fitbit}
		
	end
	

	def photos
	  
    #album = Album.where(:account_id => @profileuser.id).order("id DESC")
      if @friend.present? && @friend.approved ==true
        	albums = Album.where("account_id = ? AND share_with != ?   ", @profileuser.id, "Private").order("id DESC")
        elsif @profileuser.id == current_user.id
            albums = Album.where(:account_id => @profileuser.id).order("id DESC")	
        else            
		    albums = Album.where("account_id = ? AND share_with = ?",  @profileuser.id, "Public").order("id DESC")
        end
         
         al_bums = Array.new  
         albums.each do |album|
         hash = {}
         hash[:album] = album
         hash[:album_images] = {}
	           if album.album_images.present?	          
				album.album_images.each do |images|
				  hash[:album_images][images.id] = images				  		  
				end
		      end	
		   al_bums.push(hash)  		
	     end
      
    render :json => {'album' => al_bums, 'profile_user' => @profileuser, 'friend' => @friend}
	end

    #params : username
    #return : activities
	def activities
	 
	 activities =    @profileuser.account_activity.present? ? @profileuser.account_activity : nil	
	 activity_array = {}
	 if @profileuser.account_activity.present?
	  @profileuser.account_activity.each do |activity| 
	  if activity.activity_id.present?  
         activity.activity_id.each do |key, act| 
         value =  get_activity_name(key) 
         activity_array[key] = value 
         end
      end  
      end 
     end
  
     render :json => {'activities' => activity_array, 'profile_user' => @profileuser, 'friend' => @friend}
     
    end
    # params : id as account url
	def get_user
		user = AccountUser.find_by account_url: params[:id]		
		if user
		   render :json => user
		else
		   render :json => 0   
		end
	end
	
	def members
	user = get_friend_and_member(@profileuser)
	render :json => {'friend_member' => user, 'profile_user' => @profileuser, 'friend' => @friend}
	end

	 
	def search_all
      cityid = City.select(:id).where("name Like ?", "%#{params[:search]}%").collect(&:id)   
      user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND accounts.id != #{current_user.id} AND (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ? OR zipcode LIKE ? OR user_location LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%", "%#{params[:search]}%","%#{params[:search]}%")
      groups = Group.where("lower(title) LIKE ? " , "%#{params[:search]}%")
      fitspot = Fitspot.where("lower(title) LIKE ? " , "%#{params[:search]}%")		
      render :json => {'users' => user,'groups' => groups,'fitspot' => fitspot, 'profile_user' => @profileuser, 'friend' => @friend}
    
	end 
	
	# display notification 
	# param username	
	def notifications	
    
    if  @profileuser.id != current_user.id
      render :json => 0 and return	
    end
      # friend request notification status seen
      friendable = Friendship.where(friend_id: current_user.id) 
      if friendable.present?
        friendable.each do |ff|
          ff.update_attributes(seen: true)
        end
      end	
      #group joining notification mark view seen
      get_group = Group.where(:account_id => current_user.id).collect(&:id) 
      if get_group.present?
         joining_request = GroupMember.where("group_id IN (?) && status = ?  ", get_group, false )
      end
      if joining_request.present?
        joining_request.each do |ff|
          ff.update_attributes(seen: true)
        end
      end	
      #update all notificaton of fitspot event 
      fitspot = FitspotMember.where(:account_id => current_user.id,:status => false)
      if fitspot.present?
        fitspot.each do |fs|
          fs.update_attributes(seen: true)
        end
      end   
      render :json => {'friendable' => @profileuser.requested_friendships, 'joining_request' =>joining_request, 'fitspot' => fitspot, 'profile_user' => @profileuser, 'friend' => @friend}
    
  end
  
  
  
	def appointments
	   
    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
    if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
    end	
		@profile = 'profile_appointments'
		render 'index'
	end
  # display review on profile page
  # params userename and auth token in header
  def reviews
	   
    reviews = Review.where(:gym_id => @profileuser.id).order("id DESC")	  
    all_reviews = Array.new  
      if reviews.present?
         reviews.each do |review|         		     						
		 acc = {}          						
		 acc[:review] = review	
		 acc[:user] = {}	
		 acc[:user][:id] = review.account.id		     						
		 acc[:user][:first_name] = review.account.first_name
		 acc[:user][:last_name] = review.account.last_name
		 acc[:user][:user_name] = review.account.user_name
		 acc[:user][:pic] = review.account.pic
		 acc[:user][:avatar] = review.account.avatar		

		 all_reviews.push(acc)
	   end
    end
	render :json => {'reviews' => all_reviews, 'friend' => @friend, 'profile_user' => @profileuser}
	end
	
  
 
end
