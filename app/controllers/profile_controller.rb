class ProfileController < ApplicationController

	before_action :get_account, :get_user
	before_action :get_profile_user, except: [:search_people, :new_friends_and_members, :update_cover, :dashboard, :classes, :gym_admin_appointments, :gym_trainors, :gym_members, :get_check_in_count, :get_most_active_members]
    include ApplicationHelper
	def index
	    
	   
    if !@profileuser.present?
			redirect_to('/feed')
    else
			#@posts = Post.where(:status=>1, :account_id =>@profileuser.id).order("id DESC")	
			 frnds = get_frineds_ids(@profileuser.id)
			if @profileuser.id != @account.id			
			@posts = Post.where("status = ? AND share_with != ? AND account_id = ? ",1 ,"Private", @profileuser.id).order("id DESC").paginate(:page => params[:page], :per_page => 10)
			else
			@posts = Post.where("status = ? AND account_id = ? ",1 , @profileuser.id).order("id DESC").paginate(:page => params[:page], :per_page => 10)
			end
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
	
	def trainers
	
	    @trainers = get_gym_trainors
		@profile = 'profile_trainers'
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
	   
    @reviews = Review.where(:gym_id => @profileuser.id).order("id DESC")	    
		@profile = 'profile_reviews'
		render 'index'
	end
	
	def show_classes
	   
        @gym_class = GymClass.where("account_id = ? AND  Date(class_date) = ?", @profileuser.id, Date.today)
		@profile = 'profile_classes'
		render 'index'
	end
	
	
	def update_cover
  
    @acc = Account.find(@account.id)
    @acc.update_attribute(:cover, params[:cover])	
    flash[:notice] = "Cover has been updated successfully."
    redirect_to request.env['HTTP_REFERER'] and return
    
  end
	
	
	
	def dashboard
	
	  if @account.user_type != 3
         redirect_to '/feed' and return
      end
      d = Date.today      
      date = d.at_beginning_of_week
      @active_members = Checkin.where('account_gym_id =? AND DATE(checkins.created_at) > ? ', @account.account_gym.id, date).select("COUNT(checkins.account_id) AS total, checkins.* ").group("account_id").order('total desc').limit(5)
      @Gym_trainer = GymTrainerAppointment.where("account_id =? AND Date(appointment_date) > ?",  @account.id, Date.today).group(:trainer_id)
      @appointment_count = GymTrainerAppointment.where("account_id =? AND Date(appointment_date) > ?",  @account.id, Date.today).count
      
    
	end
	
	def get_check_in_count # 
	   if request.xhr?    
			 date = params[:date];	
	         if params[:date].present? && params[:date] == 'Today'
	           date = Date.today
	         elsif  params[:date] == 'Yesterday'
	           date = Date.today-1
	         end  
	         
	         render :json => Checkin.count_all(@account.account_gym.id, date )  and return    
		end
    end
    
    def get_most_active_members # 
	   if request.xhr?    	
	         d = Date.today 		
	         if params[:date].present? && params[:date] == 'year'
	           date = d.at_beginning_of_year
	         elsif  params[:date] == 'month'
	           date = d.at_beginning_of_month
	         else  
	            date = d.at_beginning_of_week
	         end  
	         @active_members = Checkin.where('account_gym_id =? AND DATE(checkins.created_at) > ? ', @account.account_gym.id, date).select("COUNT(checkins.account_id) AS total, checkins.* ").group("account_id").order('total desc').limit(5)
	         
		end
    end
  
	
	def classes
	
	@gym_class = GymClass.where("account_id = ? AND  Date(class_date) = ?", @account.id, Date.today)
	@count_as_time = GymClass.where("account_id = ? AND  Date(class_date) = ?", @account.id, Date.today).select("COUNT(gym_classes.class_time) AS total, gym_classes.* ").group("class_time")
	 
		
			 
	end
	
	def gym_admin_appointments
	
	@gta = GymTrainerAppointment.new
	@appointments = GymTrainerAppointment.where("account_id =? AND Date(appointment_date) > ?",  @account.id, Date.today).group(:trainer_id)
	start_date = Date.today.beginning_of_week
	end_date = Date.today.end_of_week
		if @appointments.present?
		@weekly_appointments = GymTrainerAppointment.where("trainer_id = ? AND  Date(appointment_date) > ? AND Date(appointment_date) < ? ", @appointments.first.trainer_id, start_date, end_date)
		end	 
	end
	
	def gym_trainors	
	
	 @trainers = get_gym_trainors(@profileuser)
		 
	end
	
	def gym_members
	
		 
	end
  
  
 
end
