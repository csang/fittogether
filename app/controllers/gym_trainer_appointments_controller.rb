class GymTrainerAppointmentsController < ApplicationController
  before_filter :get_account
  
  def new
  	
  end

  def create  
 
     if !GymTrainerAppointment.between(@account.id, params[:trainer_id],params[:appointment_date]).present?    
		 @create = GymTrainerAppointment.create(schedule_params.merge(:account_id => @account.id))
		  if @create.save!
			  render :json => 1 and return     
		  else
			render :json => @create.errors.full_messages   and return     
		  end  
	 else
	    render :json => 0   and return   
	 end	  
  end

  def update
  end

  def delete
  end
  
  def get_weekly_appointment
   if request.xhr?  
    start_date = Date.today.beginning_of_week
    if params[:week_start].present?
    start_date = Date.parse(params[:week_start])
    end   
	end_date = Date.today.end_of_week
	if params[:week_start].present?
    end_date = Date.parse(params[:week_end])
    end  
    @weekly_appointments = GymTrainerAppointment.where("trainer_id = ? AND  Date(appointment_date) > ? AND Date(appointment_date) < ? ", Base64.decode64(params[:trainer_id]), start_date, end_date)
	 respond_to do |format|
		format.js
	   end 
   end 
  end
  
  def get_working_trainer
     if request.xhr? 
			 if params[:date].present? && params[:date] == 'Yesterday'
	           date = Date.today-1
	         else  params[:date] == 'Yesterday'
	           date = Date.today
	         end 
			@Gym_trainer = GymTrainerAppointment.where("account_id =? AND Date(appointment_date) > ?",  @account.id, date).group(:trainer_id)
	  
	  respond_to do |format|
		format.js
	   end 	
   end
  end
  
  	def get_appointment_count # 
	   if request.xhr?    
			 date = params[:date];	
	         if params[:date].present? && params[:date] == 'Today'
	           date = Date.today
	         elsif  params[:date] == 'Yesterday'
	           date = Date.today-1
	         end  
	         
	         render :json => GymTrainerAppointment.where("account_id =? AND Date(appointment_date) > ?",  @account.id, date).count    
		end
    end
  
  private
  def schedule_params
  
	  params.permit(:trainer_id, :morning_start_time, :morning_end_time, :afternoon_start_time, :afternoon_end_time, :evening_start_time, :evening_end_time, :appointment_date, :total_slot) 
  
  end
end
