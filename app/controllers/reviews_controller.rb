class ReviewsController < ApplicationController
  before_action :get_account
  def index
  end

  def new
  end
  
  def creat
    id = Base64.decode64(params[:review][:gym_id])
    review =  Review.create(review_params.merge(:account_id => @account.id).merge(:gym_id => id))
  
      if review.save
         flash[:notice] = 'Review saved succesfully'
          @user = Account.find(id)
        met = email_settings(id, 'new_review')
        if met.present? || met == 123 
         UserMailer.new_review(@user.email,request, @account, @user.first_name, params[:review][:review]).deliver
        end
         u_name = Account.select(:user_name).where(:id => id).first
      
				 redirect_to request.env['HTTP_REFERER'] and return
  	else
      flash[:error] = review.errors.full_messages.first
      redirect_to request.env['HTTP_REFERER'] and return
    end 	    
  end
  
  private
     def review_params
      params.require(:review).permit(:review) 
    end
  
  
end
