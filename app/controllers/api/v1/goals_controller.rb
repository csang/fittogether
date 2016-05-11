class Api::V1::GoalsController < Api::V1::BaseController
  before_action :authenticate_with_token!
  before_action :check_post, :except => [:index,:delete_goal,:edit] # check if request.post?
  include ApplicationHelper
  
  def create #create new goals for user
  
      to_id = current_user.id
      if params[:to_id].present? # if not than create goals for self
         to_id = Base64.decode64(params[:to_id])
      end
      goal = AccountGoal.create(goal_params.merge(:account_id => current_user.id,:for_id=> to_id))
      if goal.save
           render :json => {success: "Goal Created Successfully!", goal: goal }  and return
      else
		   render :json => {errors: "Please Try Again!"} and return
      end 	
  end	
	
  def index #list all goals of current user

    all_goals = AccountGoal.where("for_id =? or account_id =?", current_user.id, current_user.id).order('id desc').paginate(:page => params[:page], :per_page =>15)	
    goals = Array.new
    hash = {}
    all_goals.each do |goal|
		hash[:goal] = goal
		hash[:user] = get_user_array(goal.account) #required user info for array 
		goals.push(hash)
    end		
    
    render :json => {goals: goals }  and return 
  end
  
  def delete_goal
	
      cid = Base64.decode64(params[:cid])				 
      goal = AccountGoal.where('id = ? and account_id=?',cid, current_user.id).first #if user is creater of goal
      if goal.present? && goal.delete
            render :json => cid  and return     
      else
            render :json => {errors: "Please Try Again!"} and return
       
      end
      
  end
  
  
  def change_goal_status
 
      cid = Base64.decode64(params[:cid])		     
      goal = AccountGoal.find_by_id(cid)
      if goal        
         if goal.update(status: params[:status])   
            render :json => cid  and return   
         else
            render :json => 0  and return   
         end     
      end
      
  end
  
  
def edit
  id = Base64.decode64(params[:id])		     
  goal = AccountGoal.where(:id => id,:account_id =>current_user.id).first #get goals from db
  if params[:account_goal].present? && request.post?
    if goal.update_attributes(goal_params)
      goal = AccountGoal.where(:id => id,:account_id =>current_user.id).first #updated goals
    else
      render :json => {errors: "Please Try Again!"} and return
    end  
  end
  goals = Array.new #main array
  hash = {}
  hash[:goal] = goal
  hash[:user] = get_user_array(goal.account)
  goals.push(hash) #push goal and user into array
  render :json => {goals: goals }  and return 
  
end

private

def goal_params
    params.require(:account_goal).permit(:qty, :text, :valid_till, :goal_id)
  end



end
