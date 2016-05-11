class Api::V1::RatingsController < Api::V1::BaseController

  before_action :authenticate_with_token!
  before_action :check_post  # check if request.post?
  before_action :profile_user
  
  def update
    rating = Rating.find(params[:id])
    if rating.update_attributes(score: params[:score])
       user = Account.find(rating.trainer_id)
        met = email_settings(user.id, 'new_rating')
        if met.present? || met == 123 
          #UserMailer.new_rating(user.email,request, current_user, user.first_name, params[:score] ).deliver
        end
     render :json => {success: "raiting Created Successfully!", rating: rating }  and return
    end
  end

end
