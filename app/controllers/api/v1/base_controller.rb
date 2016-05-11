class Api::V1::BaseController < ApplicationController
  # jsonp :parameter => :jsonp
  # before_filter :authenticate_user!
  protect_from_forgery with: :null_session
  before_action :destroy_session
  include Authenticable
  include ApplicationHelper

  def profile_user
  
   @profileuser = Account.where(:status =>1,:user_name =>params[:id]).first
   if !@profileuser.present?
		render :json => { :errors => 'User not available'} 
   else
     @rating = Rating.where(trainer_id: @profileuser.id, account_id: current_user.id).first 
    unless @rating 
      @rating = Rating.create(trainer_id: @profileuser.id, account_id: current_user.id, score: 0) 
    end
    
    # chk the friendship of logged in user and profile user
		@friend = Friendship.where(:account_id => current_user.id , :friend_id =>@profileuser.id).first 
		if !@friend.present?
		@friend = Friendship.where(:account_id => @profileuser.id  , :friend_id => current_user.id).first 
		end	
    end
    
  end
   

  def destroy_session
    request.session_options[:skip] = true
  end

  def default_serializer_options
    {
      root: false
    }
  end

  def render_error(object)
    render json: object.errors, status: :unprocessable_entity
  end
  
  def check_post
  
  render :json => {errors: 'Request type not allowed'} and return unless request.post? || request.put?
  end

  # def current_user
  #   @current_user
  # end

  # def require_authentication!
  #   error! :unauthenticated if current_user.nil?
  # end

  # def authenticate_user_from_token
  #   user = authenticate_with_http_token do |token, options|
  #     user_id = options[:user_id]
  #     user = user_id && User.find_by_id(user_id)

  #     if user && user.token_valid?(token)
  #       user
  #     else
  #       nil
  #     end
  #   end
  #   @current_user = user 
  # end
end
