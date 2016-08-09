class Api::ActivitiesController < ApplicationController
before_action :get_account
  def index
    activity_date = 'today'
  begin
    @activities = Fitbit::Activity.fetch_all_on_date(@account, activity_date)
   #abort( @activities.inspect)
   if !@activities.present?
     flash[:error] = "Error processing in api.Please try after sometime."
      redirect_to request.env['HTTP_REFERER'] and return
    elsif @activities['errors'].present?
      flash[:error] = "Error processing in api.Please try after sometime."
      redirect_to request.env['HTTP_REFERER'] and return
 
    elsif @activities.present?
    
      @activities['goals']['caloriesOut']
      @activities['summary']['caloriesOut']
      @activities['goals']['steps']
      @fit = Fitbit.where(:account_id => @account.id).first
   
      if !@fit.present?
         Fitbit.create(:account_id => @account.id, :steps =>@activities['goals']['steps'], :calories =>@activities['goals']['caloriesOut'], :distance =>@activities['goals']['distance'], :summary_calories =>@activities['summary']['caloriesOut'])
		  Post.create(:account_id=>@account.id,:text=>'Fitbit', :status=>1,:share_with=> 'Public',:post_type=> 'fitbit')
	     else       
         @fit.update_attributes(:steps =>@activities['goals']['steps'], :calories =>@activities['goals']['caloriesOut'], :distance =>@activities['goals']['distance'], :summary_calories =>@activities['summary']['caloriesOut'])
		  Post.create(:account_id=>@account.id,:text=>'Fitbit', :status=>1,:share_with=> 'Public',:post_type=> 'fitbit')
      end  

    else
      flash[:error] = "Error processing in api.Please try after sometime."
      redirect_to request.env['HTTP_REFERER'] and return
    end
    rescue
         flash[:error] = "Error processing in API. Please try after sometime."
         redirect_to request.env['HTTP_REFERER'] and return
      end
   # abort(@activities.inspect)
  
  end
=begin  
        def create

          if params[:activityId].present?
        #abort(params.inspect)
          activity_data = {
            activityId: params[:activityId],
            durationMillis: params[:duration].to_i*60*1000,
            startTime: params[:startTime],
            date: params[:date],
            distance: params[:distance],
            distanceUnit: Fitgem::ApiDistanceUnit.miles
          }
          @activity = Fitbit::Activity.log_activity(@account, activity_data)
        end
      end
=end
  
 def fitness_tracking
  
 begin
    @activities = Fitbit::Activity.fetch_weekly_goal(@account)
    @recent_activities = Fitbit::Activity.fetch_recent_activity(@account)
  # abort( @activities.inspect)
   if !@activities.present?
     flash[:error] = "Error processing in api.Please try after sometime."
      redirect_to request.env['HTTP_REFERER'] and return
    elsif @activities['errors'].present?
      flash[:error] = "Error processing in api.Please try after sometime."
      redirect_to request.env['HTTP_REFERER'] and return
 
    elsif @activities.present?
     # do not do anything here
    else
      flash[:error] = "Error processing in api.Please try after sometime."
      redirect_to request.env['HTTP_REFERER'] and return
    end
   rescue
       flash[:error] = "Error processing in API.Please try after sometime."
       redirect_to request.env['HTTP_REFERER'] and return
    end
    
  
  end
  
 
 def create_update_goal
 
if params[:type].present?
  
@data = Hash.new
@data[:type] =  params[:type]== 'steps' ? :steps : :distance
@data[:value] = params[:value]

 begin 
 @wg = Fitbit::Activity.update_weekly_goal(@account, @data)
 if @wg.present?
   redirect_to api_fitness_tracking_path and return
 else
    flash[:error] = "Please Try Again."
       redirect_to request.env['HTTP_REFERER'] and return
 end
 rescue
       flash[:error] = "Error processing in API.Please try after sometime."
       redirect_to request.env['HTTP_REFERER'] and return
    end

end     
    end
  
  end



