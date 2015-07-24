class ProfileController < ApplicationController

	before_action :get_account, :get_user
	before_action :get_profile_user, except: :search_people

	def index
	    
	   
    if !@profileuser.present?
			redirect_to('/feed')
    else
			@posts = Post.where(:status=>1, :account_id =>@profileuser.id).order("id DESC")	
			@friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
			if !@friend.present?
        @friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
			end	
		
			@profile = 'profile_fit_feed'
		end
   
  
	end

	def fit_feed
	 
    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
    if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
    end	
	   
		@profile = 'profile_fit_feed'
		render 'index'
	end

	def about
	
    @profile = 'profile_about'
	
    @allchalenge = Challenge.where("challenges.account_id =? OR challenges.to_id =? AND(sender_status=?) ", @profileuser.id,@profileuser.id,1).count
    @chal = Challenge.where("challenges.valid_till < ? AND (challenges.account_id =? OR challenges.to_id =? ) ", Date.today, @profileuser.id,@profileuser.id).count
    @echal = Challenge.where("(status =? and challenges.account_id!=?) AND (challenges.account_id =? OR challenges.to_id =? ) and challenges.valid_till > ? ", 'reject', @profileuser.id, @profileuser.id,@profileuser.id, Date.today).count
	  @chal = @chal + @echal;
    if (@profileuser.user_type==3)
      @profileuser_gyms = @profileuser.account_gym
    end
    if (@account_type.to_i == 2) 
      @trainer_details= AccountTrainer.where(:account_id => @account.id).first
    end
    if (@account_type.to_i == 3) 
      @account_gyms = AccountGym.where(:account_id => @account.id).first
    end
     
		render 'index'
	end

	def photos
	  
    @album = Album.where(:account_id => @profileuser.id).order("id DESC")
    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
    if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
    end	
		@profile = 'profile_photos'
		render 'index'
	end

	def videos
	  
    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
    if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
    end	
		@profile = 'profile_videos'
		render 'index'
	end

	def friends
	   
    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
    if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
    end	
		@profile = 'profile_friends'
		render 'index'
	end

	def activities
	  
    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
    if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
    end	
		@profile = 'profile_activities'
		render 'index'
	end

	def get_user
		@user = AccountUser.find_by account_url: params[:id]
	end
	
	def members
	
		@friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
    if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
    end	
		@profile = 'profile_members'
		render 'index'
	end

	 
	def search_people
    if request.xhr?   
      cityid = City.select(:id).where("name Like ?", "%#{params[:search]}%").collect(&:id)
   
      @user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND accounts.id != #{@account.id} AND (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ? OR zipcode LIKE ? OR city_id IN (?))", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%", "%#{params[:search]}%",cityid)
    
      @groups = Group.where("lower(title) LIKE ? " , "%#{params[:search]}%")
    
      @fitspot = Fitspot.where("lower(title) LIKE ? " , "%#{params[:search]}%")
		
      respond_to do |format|
        format.js       
      end
    
    end
	end 
	
		
	def notifications
	
	
    if !@profileuser.present?
      redirect_to('/feed') and return
    end	
    if  @profileuser.id != @account.id
      redirect_to('/feed')	
    else
      friendable = Friendship.where(friend_id: @account.id) 
      if friendable.present?
        friendable.each do |ff|
          ff.update_attributes(seen: true)
        end
      end	
      get_group = Group.where(:account_id => @account.id).collect(&:id) 
      if get_group.present?
        @joining_request = GroupMember.where("group_id IN (?) && status = ?  ", get_group, false )
      end
      if @joining_request.present?
        @joining_request.each do |ff|
          ff.update_attributes(seen: true)
        end
      end	
  
      @fitspot = FitspotMember.where(:account_id => @account.id,:status => false)
      if @fitspot.present?
        @fitspot.each do |fs|
          fs.update_attributes(seen: true)
        end
      end   
  
      @profile = 'profile_notifications'
      render 'index'
    end	
	end
  
  
  
	def appointments
	   
    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
    if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
    end	
		@profile = 'profile_appointments'
		render 'index'
	end
  
  def reviews
	   
    @reviews = Review.where(:gym_id => @profileuser.id)    
		@profile = 'profile_reviews'
		render 'index'
	end
	
  
 
end
