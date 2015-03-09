class ProfileController < ApplicationController

	before_action :get_account, :get_user

	def index
	    
	    @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
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
	     @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
	     @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
			if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
			end	
	   
		@profile = 'profile_fit_feed'
		render 'index'
	end

	def about
	
	 @profile = 'profile_about'
	  @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
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
	    @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
	    @album = Album.where(:account_id => @profileuser.id).order("id DESC")
	    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
			if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
			end	
		@profile = 'profile_photos'
		render 'index'
	end

	def videos
	    @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
	    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
			if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
			end	
		@profile = 'profile_videos'
		render 'index'
	end

	def friends
	    @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
	    @friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
			if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
			end	
		@profile = 'profile_friends'
		render 'index'
	end

	def activities
	    @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
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
		@profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
		@friend = Friendship.where(:account_id => @account.id , :friend_id =>@profileuser.id).first 
			if !@friend.present?
			@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id =>@account.id).first 
			end	
		@profile = 'profile_members'
		render 'index'
	end

	 
	def search_people
	 if request.xhr?   
		
		@user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND accounts.id != #{@account.id} AND (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")
		
		 respond_to do |format|
      format.js       
     end
    
	 end
	end 
	
		
	def notifications
	
	 @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
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
	 @profile = 'profile_notifications'
	 render 'index'
	 end	
	end
	
  
 
end
