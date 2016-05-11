class Api::V1::AppointmentsController < Api::V1::BaseController
  before_action :authenticate_with_token!
  before_action :check_post, :except => [:get_user_appointment, :delete_user_event] # check if request.post?
  before_action :profile_user, :except => [:save_user_appointment, :delete_user_event]
  include ApplicationHelper
  
    
    def get_user_appointment 
    
       if current_user.id != @profileuser.id #pid is trainer id or profile user id
        user_events = Appointment.where("account_id = ? AND trainor_id=?",current_user.id, @profileuser.id).where("start_date >= '"+params["start"]+"' AND end_date <= '"+params["end"]+"'")
       else
        user_events = Appointment.where("account_id = ? or trainor_id=?",current_user.id, @profileuser.id).where("start_date >= '"+params["start"]+"' AND end_date <= '"+params["end"]+"'")
       end
        events = []
       # abort(user_events.inspect)
       if user_events.present?
        user_events.each do |ue|
              event = {}
              event["id"] = ue.id          
              event["description"] = ue.description
              event["title"] =  ue.title 
              event["backgroundColor"] = ue.status==1 ? 'light blue' : '#2f8352'
              event["start"] = ue.start_date
              event["account_id"] = ue.account_id
              event["trainer_id"] = ue.trainor_id
              event["status"] = ue.status
          
            #  event["textColor"] = '#004ea6'
                      
         events.push(event)      
        end
        end
        render :json=> {events: events }and return
    end
    
  
  
    def save_user_appointment 
     
        if params["user_event"]["id"].to_i == 0 
            user_event = Appointment.new # create new object in case not exist
        else 
            user_event = Appointment.find(params["user_event"]["id"].to_i) #get if already avaiable 
        end
        res = {}
        res["status"] = "error"
        if user_event.update_attributes(user_event_params)
            id = user_event.id
            res["status"] = "ok"
            res["event_id"] = id
            res["user_id"] = user_event.account_id
            res["start"] =   user_event.start_date
            met = email_settings(user_event.trainer.id, 'new_appointment_request')
           if met.present? || met == 123 
            # UserMailer.new_appointment_request(user_event.trainer.email,request, current_user, user_event).deliver
           end
        end  
        render :json=> res and return
    end
    
     def delete_user_event
        res = {}
        res["status"] = "ok"
        user_events = Appointment.where(:id => params["id"])
        user_events.delete_all
        render :json=> res and return
    end
    
     
      def approve_user_event
        res = {}
        res["status"] = "ok"
        user_event = Appointment.find(params["id"])
       if user_event.update_attributes(:status => 2) #2 => approve
          met = email_settings(user_event.account_id, 'appointment_approve')
           if met.present? || met == 123 
           # UserMailer.approve_appointment_request(user_event.account.email,request, current_user, user_event).deliver
           end
        render :json=> res and return
       else
          render :json=> 0 and return
       end   
    end
    
 private   
	 def user_event_params
        params.require(:user_event).permit(:account_id,:start_date,:end_date,:title,:description,:trainor_id)
    end
    
end    
