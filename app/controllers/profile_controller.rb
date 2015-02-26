class ProfileController < ApplicationController

	before_action :get_account, :get_user

	def index
		@profile = 'profile_fit_feed'
	end

	def fit_feed
		@profile = 'profile_fit_feed'
		render 'index'
	end

	def about
		@profile = 'profile_about'
     if (@account_type.to_i == 2) 
       @trainer_details= AccountTrainer.where(:account_id => @account.id).first
     end
		render 'index'
	end

	def photos
		@profile = 'profile_photos'
		render 'index'
	end

	def videos
		@profile = 'profile_videos'
		render 'index'
	end

	def friends
		@profile = 'profile_friends'
		render 'index'
	end

	def activities
		@profile = 'profile_activities'
		render 'index'
	end

	def get_user
		@user = AccountUser.find_by account_url: params[:id]
	end
  
 
end
