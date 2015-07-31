class RatingsController < ApplicationController
before_action :get_account
  def update
    @rating = Rating.find(params[:id])
    if @rating.update_attributes(score: params[:score])
       @user = Account.find(@rating.trainer_id)
        met = email_settings(@user.id, 'new_rating')
        if met.present? || met == 123 
          UserMailer.new_rating(@user.email,request, @account, @user.first_name, params[:score] ).deliver
        end
      respond_to do |format|
        format.js
      end
    end
  end

end
