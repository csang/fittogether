class LandingController < ApplicationController

  before_action :logged_in , :except => [:login, :logout]

  def index
  end

  def login
 
  if self.current_user
	redirect_to('/feed')
  elsif session[:fit_id].present?
       redirect_to('/feed')
    end
  end

  def logout
    session.clear
    cookies.delete(:auth_token)
    redirect_to('/login')
  end

  private

  def logged_in 
     redirect_to('/feed')
  end

end
