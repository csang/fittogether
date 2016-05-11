class Api::V1::ChallengesController < Api::V1::BaseController
   before_action :authenticate_with_token!
   before_action :check_post, :except => [:show,:index,:show_team_challenge,:search_user] # check if request.post?
   include ApplicationHelper
 
  def create

      to_id = Base64.decode64(params[:to_id]) # chellegne to
      account_id = params[:rip2].present? ? Base64.decode64(params[:rip2]) : ''  #chellenger
      if account_id.present? # in case trainer is creating chellenge 
       challenge = Challenge.create(chall_params.merge(:account_id =>account_id,:to_id=> to_id, :creater_id=> current_user.id))
      else  # user directly creating chellenge
       challenge = Challenge.create(chall_params.merge(:account_id =>current_user.id,:to_id=> to_id))     
      end  
      
	  if challenge.save
        render :json => 1  and return     
      else
		 render :json => { errors: challenge.errors.full_messages  }  and return
      end 	
     end	
	
  def index
    #get  challenge of logged in user
   if current_user.user_type != 1 
       render :json => { errors: "Not Allowed"  }  and return
   end 
    all_challenge = Challenge.involving(current_user.id).order('id desc').paginate(:page => params[:page], :per_page =>15)	
    chl = Challenge.where(to_id: current_user.id) 
    if chl.present?
      chl.each do |ff|
        ff.update_attributes(is_read: true)
      end
    end	
     render :json => {"all_challenge" =>all_challenge}     
  end
  
  
  # method for trainers to show challenge to trainers of their teammates
  def show_team_challenge
    #no one can access this method except trainer
   if current_user.user_type != 2 
       render :json => { errors: "Not Allowed"  }  and return
   end 
   teammate = [];
   #to get teammates
   current_user.passive_friends.each do |afriend|
       teammate.push(afriend.id)
   end
    #to get teammates
   current_user.active_friends.each do |pfriend|
       teammate.push(pfriend.id)
   end
   #get challenges of teammantes
 
   all_team_challenge = Challenge.where("sender_status != ? AND (account_id IN  (?) OR to_id IN  (?) OR creater_id = ?)",false, teammate, teammate, current_user.id).order('id desc').paginate(:page => params[:page], :per_page =>10)	
   challenges = Challenge.where(to_id: current_user.id) 
   render :json => {"challenges" =>challenges, "all_team_challenge" => all_team_challenge}     
  end

  
 
  def del_challenge # update sender-status
	
      cid = Base64.decode64(params[:cid])	# primary key challenge id			 
      challenge = Challenge.where('id = ? and account_id=?',cid,current_user.id).first #chk ownership of challenge , current user must be creater to change the status
      if !challenge
           render :json => {errors: "No Such Challenge!"}  and return
      else        
			if challenge.update(sender_status: false)   
			    render :json => {success: "Challegne Update Successfully!", id: cid }  and return
			else
			   render :json => {errors: "Please Try Again!"} 
			end     
      end
      
	end
  
  
  def change_challenge_status #update status 
 
      cid = Base64.decode64(params[:cid])	#param coversation id base 64 encoded	       
      challenge = Challenge.find_by_id(cid)
      if !challenge
           render :json => {errors: "No Such Challenge!"}  and return
      else          
         if challenge.update(status: params[:status])    # accept/reject/cancel etc
             render :json => {success: "Challegne Update Successfully!", id: cid }  and return
         else
             render :json => {errors: "No Such Challenge!"} and return
         end    
      end
    
    
  end
  
  
	def edit # edit challenge 
	
	  cid = Base64.decode64(params[:id])		     
	  challenge = Challenge.where(:id => cid,:account_id =>current_user.id).first
	  if params[:challenge].present?
		if challenge.update_attributes(chall_params) # params like :qty, :text, :valid_till, :category_id, :reward_points
		   render :json => {success: "Challegne Update Successfully!", id: cid }  and return
	    else
		   render :json => {errors: "Please Try Again!"} and return
	    end
	  end 
	  
	end

  
  def update_reward_points #method update reward points 

      cid = Base64.decode64(params[:cid]) #challenge table  id		     
      challenge = Challenge.find_by_id(cid)
      if challenge.present?        
       #abort(params[:account_id].inspect)
       if !challenge.winner_id.present? # new winner declare
        acc =   Account.find(challenge.account_id)
        acc1 =   Account.find(challenge.to_id)
        winrid = params[:account_id].to_i
         if acc.id.to_i == winrid   # add reward points to winner and substract reward point from looser
           acc.update_attributes(reward_points: acc.reward_points.to_i + challenge.reward_points.to_i)
           acc1.update_attributes(reward_points_lost: acc1.reward_points_lost.to_i + challenge.reward_points)
         else
           acc.update_attributes(reward_points_lost: acc.reward_points_lost.to_i + challenge.reward_points)
           acc1.update_attributes(reward_points: acc1.reward_points.to_i + challenge.reward_points.to_i)
         end  
      else #in case trainer wants to change winner
         # add reward points to winner and substract reward point from looser
        newlooser =   Account.find(challenge.winner_id)  
        newwinner =   Account.find(params[:account_id])          
        newlooser.update_attributes(reward_points: newlooser.reward_points.to_i - challenge.reward_points.to_i, reward_points_lost: newlooser.reward_points_lost.to_i + challenge.reward_points.to_i)
        newwinner.update_attributes(reward_points: newwinner.reward_points.to_i + challenge.reward_points.to_i, reward_points_lost: newwinner.reward_points_lost.to_i - challenge.reward_points.to_i)
      end    
      #change status and add winner id into table
      abc =  challenge.update_attributes(status: 'completed', winner_id: params[:account_id])        
       
      end
      
      if abc         
        render :json => {success: "Challegne Update Successfully!", id: cid }  and return
      else
        render :json => {errors: "Please Try Again!"} and return
      end
 
    
  end
  
# method to search user and show in drop down on new challenge/goals dropdown
	def search_user
     if !params[:type].present?	    
        if params[:uid].present? && params[:uid].strip == 'group' #in case search from chat window
          cm = ConversationMember.where(:conversation_id => Base64.decode64(params[:conv_id].to_s))
          account_ids = cm.map(&:account_id).join(',')           #get already members of conversation to avoid to show aleady member 
          user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND accounts.id != #{current_user.id} AND accounts.id NOT IN (#{account_ids}) AND accounts.user_type NOT IN (2,3)  AND (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%") 
        else
         uid = params[:uid].present? ? Base64.decode64(params[:uid]) : 0
         user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND accounts.id != #{current_user.id} AND accounts.id != #{uid} AND accounts.user_type NOT IN (2,3)  AND (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")  
        end         
    else
        user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND  (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")  
    end
    
      if user         
        render :json => {user: user }  and return
      else
        render :json => {errors: "No User Found!"} and return
      end
 end 
 
private 
def chall_params
    params.require(:challenge).permit(:qty, :text, :valid_till, :category_id, :reward_points)
  end



end
