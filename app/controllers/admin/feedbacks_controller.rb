class Admin::FeedbacksController < ApplicationController
   before_filter :authenticate_admin!
   layout "admin"
 

  def index
    @admin_feedbacks = Admin::Feedback.order('id desc').paginate(page: params[:page], per_page: 10)
    
  end

    def search

      @admin_feedbacks = Admin::Feedback.where("lower(feedback) LIKE ?", "%#{params[:search]}%" ).paginate(page: params[:page],per_page: 10)

	end
	
    
    def show
 
    @admin_feedback = Admin::Feedback.find(params[:id])
 
    if !@admin_feedback.blank?	
      respond_to do |format|
        format.html
        format.json { render json: @admin_feedback }
      end
    else
      redirect_to action: 'index'
    end
  end

  
 

  def destroy
    @admin_feedback = Admin::Feedback.find(params[:id])
    if @admin_feedback.present?
     if  @admin_feedback.destroy
      respond_to do |format|
         flash[:notice]=  'Feedback was successfully destroyed.'
        format.html { redirect_to action: 'index'}       
      end
     else 
         flash[:alert]=  'Please try again.'
        format.html { redirect_to action: 'index' }   
     end 
    else 
       redirect_to action: 'index'
    end
  end
 
  
 

  private
    def set_admin_feedback
      @admin_feedback = Admin::Feedback.find(params[:id])
    end

    def admin_feedback_params
      params.require(:admin_feedback).permit(:category_id, :feedback)
    end
end
