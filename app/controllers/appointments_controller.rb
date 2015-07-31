class AppointmentsController < ApplicationController
    
   before_action :get_account 
  
    
    def get_user_appointment
             
       if params["id"].to_i != params["pid"].to_i
        user_events = Appointment.where("account_id = ? AND trainor_id=?",params["id"],params["pid"] ).where("start_date >= '"+params["start"]+"' AND end_date <= '"+params["end"]+"'")
       else 

        user_events = Appointment.where("account_id = ? or trainor_id=?",params["id"],params["pid"] ).where("start_date >= '"+params["start"]+"' AND end_date <= '"+params["end"]+"'")
       end
        events = []
       # abort(user_events.inspect)
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
        render :json=> events and return
    end
    
  
  
    def save_user_appointment
      # abort(params.inspect)
        if params["user_event"]["id"].to_i == 0 
            @user_event = Appointment.new
        else
            @user_event = Appointment.find(params["user_event"]["id"].to_i)
        end
        res = {}
        res["status"] = "error"
        if @user_event.update_attributes(user_event_params)
            id = @user_event.id
            res["status"] = "ok"
            res["event_id"] = id
            res["user_id"] = @user_event.account_id
            res["start"] = @user_event.start_date
           # res["start"] = @user_event.start_date.strftime("%Y-%m-%dT%H:%M:%S")
           met = email_settings(@user_event.trainer.id, 'new_appointment_request')
           if met.present? || met == 123 
             UserMailer.new_appointment_request(@user_event.trainer.email,request, @account, @user_event).deliver
           end
        end  
        render :json=> res and return
    end
    
     def delete_user_event
        res = {}
        res["status"] = "ok"
        _user_events = Appointment.where(:id => params["id"])
        _user_events.delete_all
        render :json=> res and return
    end
    
     
      def approve_user_event
        res = {}
        res["status"] = "ok"
        user_event = Appointment.find(params["id"])
       if user_event.update_attributes(:status => 2)
          met = email_settings(user_event.account_id, 'appointment_approve')
           if met.present? || met == 123 
            UserMailer.approve_appointment_request(user_event.account.email,request, @account, user_event).deliver
           end
        render :json=> res and return
       else
          render :json=> 0 and return
       end   
    end
    
	 def user_event_params
        params.require(:user_event).permit(:account_id,:start_date,:end_date,:title,:description,:trainor_id)
    end
    
end    
