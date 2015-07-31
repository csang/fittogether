class UserMailer < ActionMailer::Base
  default from: "noreply@fittogether.com"
  
  def invite(contacts, request, current_user)
    @request = request
    @current_user = current_user
    mail(:to => contacts, :subject => "Welcome to My Awesome Site")
  end
  
  
  def mentioned_in(contacts, request, current_user, type, msg, name)
    @request = request
    @current_user = current_user
    @type = type
    @msg = msg
    @name = name
    mail(:to => contacts, :subject => current_user.first_name.capitalize + " mentioned you on FitTogehter.com")
  end
  
  def new_rating(contacts, request, current_user, name, score)
    @request = request
    @current_user = current_user
    @name = name
    @score = score
    mail(:to => contacts, :subject => current_user.first_name.capitalize + " rate you on FitTogehter.com")
  end
  
  
    def new_review(contacts, request, current_user, name, review)
    @request = request
    @current_user = current_user
    @name = name
    @review = review
    mail(:to => contacts, :subject => current_user.first_name.capitalize + " review you on FitTogehter.com")
  end
  
   def new_appointment_request(contacts, request, current_user, user_event)
    @request = request
    @current_user = current_user
    @user_event = user_event  
    mail(:to => contacts, :subject => "Appointment request on FitTogehter.com")
  end  
  
   def approve_appointment_request(contacts, request, current_user, user_event)
    @request = request
    @current_user = current_user
    @user_event = user_event  
    mail(:to => contacts, :subject => current_user.first_name.capitalize + " approve appointment request on FitTogehter.com")
  end  
  
   def comment_on_post(contacts, request, current_user,  msg, name)
    @request = request
    @current_user = current_user
     @msg = msg
    @name = name
    mail(:to => contacts, :subject => current_user.first_name.capitalize + " comment on your post  on FitTogehter.com")
  end
  
   def fitspot_invitation(contacts, request, current_user, user_event)
    @request = request
    @current_user = current_user
    @user_event = user_event  
    mail(:to => contacts, :subject => current_user.first_name.capitalize + " invited you for fitspot  on FitTogehter.com")
  end  

end
