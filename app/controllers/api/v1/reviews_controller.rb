class Api::V1::ReviewsController < Api::V1::BaseController
 before_action :authenticate_with_token!
  def index
  end

  def new
  end
  
  def create_review
  # abort(params.inspect)
  
  if request.post? 
    review =  Review.create(review_params.merge(:account_id => current_user.id))  
      if review.save
        @user = Account.find(params[:review][:gym_id])
        met = email_settings(@user.id, 'new_review')
        if met.present? || met == 123 
         UserMailer.new_review(@user.email,request, current_user, @user.first_name, params[:review][:review]).deliver
        end
         render :json =>  1
     else
        render :json =>  review.errors.full_messages.first     
    end 
  end  	    
  end
  
  private
     def review_params
      params.require(:review).permit(:review,:gym_id) 
    end
  
  
end
