class GymClassesController < ApplicationController
  before_filter :get_account
  def new
  end

  def create  
       @create = GymClass.create(class_params.merge(:account_id => @account.id))
      if @create.save!
          render :json => 1 and return     
      else
        render :json => @create.errors.full_messages.first if @create.errors.any?     
      end
  
  end
  
  def classes_count_for_date  
	  if request.xhr?  
	   @count_as_time = GymClass.where("account_id = ? AND  Date(class_date) = ?", @account.id, Date.parse(params[:date])).select("COUNT(gym_classes.class_time) AS total, gym_classes.* ").group("class_time")
	   @total_count = GymClass.where("account_id = ? AND  Date(class_date) = ?", @account.id, Date.parse(params[:date])).count
	  
	   respond_to do |format|
		format.js
	   end 	
	  
	 end  
  end
  
    def get_classes  
	  if request.xhr?
	  date = Date.today
		  if params[:date].present?
		  date = Date.parse(params[:date])
		  end  
	  @gym_class = GymClass.where("account_id = ?  AND specialty_id = ? AND trainer_id = ? AND  Date(class_date) = ?", @account.id,params[:specialties],params[:trainers], date)
	   respond_to do |format|
		format.js
	   end 	
	  
	 end  
  end
  
  def get_class_slot
   if request.xhr?  
	total_slot = GymClass.select('id,total_slot').where("account_id = ? AND  Date(class_date) = ? AND specialty_id =? ", @account.id, Date.today, params[:class_id]).first
	if total_slot.present?
	occupied = ClassAttendance.where(:gym_class_id => total_slot.id).count	
    render :json =>  { 'occupied' => occupied ,'total' => total_slot.total_slot }
    else
     render :json => 0
    end
   end 
  end
  
  def attend_class
   if request.xhr?  
    attend = ClassAttendance.where(:gym_class_id => Base64.decode64(params[:gym_class_id]), :account_id => @account.id ).first
    if attend.present?
      if attend.destroy 
        render :json => 2  and return      
      else
        render :json => 0  and return     
      end
    else  
		attendance = ClassAttendance.create(:gym_class_id => Base64.decode64(params[:gym_class_id]), :account_id => @account.id )	
		if attendance.save!
			render :json => 1 and return
		else
			 render :json => 0 and return
		end
	end	   
   end  # end of xhr
   
  end
  
  def show_classes_details
	
	
       @gym_class = GymClass.where("account_id = ? AND  Date(class_date) = ?", params[:account_id], params[:tareek])
        respond_to do |format|
		format.js
	   end 	  
  end

   def remove_from_class
   if request.xhr?  
    attend = ClassAttendance.where(:id => Base64.decode64(params[:id])).first
      if attend.present?
      if attend.destroy 
        render :json => 1  and return      
      else
        render :json => 0  and return     
      end
    else
		 render :json => 0  and return    
    end 
  else
	redirect_to('/feed')	
  end
  
  end 
  
  private
  
  def class_params
  
  params.permit(:specialty_id, :trainer_id, :class_date	, :class_time, :total_slot, :duration)
  
  end
  

  
end
