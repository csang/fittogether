class GoalsController < ApplicationController
  before_filter :get_account
 
  def create
  
  
    if request.xhr?  
      
      if !params[:to_id].present?
       to_id = @account.id
      else
        to_id = Base64.decode64(params[:to_id])
      end
     
      #  abort(params.inspect)
      @goals = AccountGoal.create(:goal_id=> params[:goal_id],
		 		:account_id =>@account.id,:for_id=> to_id,:text=>params[:text],:qty=>params[:qty],:valid_till=>params[:valid_till])
			
		
      if @goals.save
        render :json => 1  and return     
      else
		    render :json => 0  and return   
      end 	
    else
      redirect_to('/goals')	 
    end
  end	
	
  def index
#	abort('dadsflksjdfks')
    @allgoals = AccountGoal.where("for_id =? or account_id =?", @account.id, @account.id).order('id desc').paginate(:page => params[:page], :per_page =>15)	
   
  end
  
  

  def show
  end

  
  def new
  end
  
  def del_goal
    if request.xhr?  
      #abort(params.inspect)
      cid = Base64.decode64(params[:cid])				 
      @goal = AccountGoal.where('id = ? and account_id=?',cid,@account.id).first
      #abort(@challenge.inspect)
      if @goal        
        abc =  @goal.delete()        
      end
      
      if abc         
        render :json => cid  and return     
      else
        render :json => 0  and return     
      end
		end
	end
  
  
  def change_goal_status
    if request.xhr?  
      cid = Base64.decode64(params[:cid])		     
      @goal = AccountGoal.find(cid)
      if @goal        
        abc =  @goal.update(status: params[:status])        
      end
      
      if abc         
        render :json => cid  and return     
      else
        render :json => 0  and return     
      end
    end  
    
  end
  
  
def edit
  cid = Base64.decode64(params[:id])		     
  @goal = AccountGoal.where(:id => cid,:account_id =>@account.id).first
  #abort(@goal.inspect)
 # abort(params.inspect)
  if params[:account_goal].present?
    if @goal.update_attributes(goal_params)
     flash[:notice] = 'Goals was successfully updated.'
     redirect_to('controller'=>'goals')
   else
     render "edit"
   end
  end
  
  
end

def goal_params
    params.require(:account_goal).permit(:qty, :text, :valid_till, :goal_id, )
  end



end
