class RatingsController < ApplicationController
before_action :get_account
  def update
    @rating = Rating.find(params[:id])
    if @rating.update_attributes(score: params[:score])
       @user = Account.find(@rating.trainer_id)
       #UserMailer.new_rating(@user.email,request, @account, @user.first_name, params[:score] ).deliver
      respond_to do |format|
        format.js
      end
    end
  end

end
