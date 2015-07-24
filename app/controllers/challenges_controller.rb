class ChallengesController < ApplicationController
  before_filter :get_account
 
  def create
   
    if request.xhr?  
      to_id = Base64.decode64(params[:to_id])
      account_id = params[:rip2].present? ? Base64.decode64(params[:rip2]) : ''
      if account_id.present?
      @challenge = Challenge.create(:category_id=> params[:category_id],
		 		:account_id =>account_id,:to_id=> to_id, :creater_id=> @account.id, :text=>params[:text],:reward_points => params[:reward_points],:qty=>params[:qty],:valid_till=>params[:valid_till])
      else
         @challenge = Challenge.create(:category_id=> params[:category_id],
		 		:account_id =>@account.id,:to_id=> to_id,  :text=>params[:text],:reward_points => params[:reward_points],:qty=>params[:qty],:valid_till=>params[:valid_till])
     
      end  
		
      if @challenge.save
        render :json => 1  and return     
      else
		    render :json => 0  and return   
      end 	
    else
      redirect_to('/challenges')	 
    end
  end	
	
  def index
    #get  challenge of logged in user
    if @account.user_type != 1 
     redirect_to('controller'=>'challenges','action' => 'show_team_challenge')
   end 
    @allchallenge = Challenge.involving(@account.id).order('id desc').paginate(:page => params[:page], :per_page =>15)	
    chl = Challenge.where(to_id: @account.id) 
    if chl.present?
      chl.each do |ff|
        ff.update_attributes(is_read: true)
      end
    end	

  end
  
  
  # method for trainers to show challenge to trainers of their teammates
  def show_team_challenge
    #no one can access this method except trainer
   if @account.user_type == 1 
     redirect_to('controller'=>'challenges')
   end 
   teammate = [];
   #to get teammates
   @account.passive_friends.each do |afriend|
       teammate.push(afriend.id)
   end
    #to get teammates
   @account.active_friends.each do |pfriend|
       teammate.push(pfriend.id)
   end
   #get challenges of teammantes
 
   @allchallenge = Challenge.where("sender_status != ? AND (account_id IN  (?) OR to_id IN  (?) OR creater_id = ?)",false, teammate, teammate, @account.id).order('id desc').paginate(:page => params[:page], :per_page =>10)	
   chl = Challenge.where(to_id: @account.id) 
  
  end

  
  def new
  end
  
  def del_challenge
    if request.xhr?  
      #abort(params.inspect)
      cid = Base64.decode64(params[:cid])				 
      @challenge = Challenge.where('id = ? and account_id=?',cid,@account.id).first
      #abort(@challenge.inspect)
      if @challenge        
        abc =  @challenge.update(sender_status: false)        
      end
      
      if abc         
        render :json => cid  and return     
      else
        render :json => 0  and return     
      end
		end
	end
  
  
  def change_challenge_status
    if request.xhr?  
      cid = Base64.decode64(params[:cid])		     
      @challenge = Challenge.find(cid)
      if @challenge        
        abc =  @challenge.update(status: params[:status])        
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
  @challenge = Challenge.where(:id => cid,:account_id =>@account.id).first
  if params[:challenge].present?
    if @challenge.update_attributes(chall_params)
     flash[:notice] = 'Challenge was successfully updated.'
     redirect_to(@challenge)
   else
     render "edit"
   end
  end
  
  
end

#method update reward 
  def update_reward_points
    if request.xhr?  
      cid = Base64.decode64(params[:cid])		     
      @challenge = Challenge.find(cid)
      if @challenge.present?  
      
       #abort(params[:account_id].inspect)
      if  !@challenge.winner_id.present?
       acc =   Account.find(@challenge.account_id)
       acc1 =   Account.find(@challenge.to_id)
       winrid = params[:account_id].to_i
        if acc.id.to_i == winrid
          # add reward points to winner and substract reward point from looser
          acc.update_attributes(reward_points: acc.reward_points.to_i + @challenge.reward_points.to_i)
           acc1.update_attributes(reward_points_lost: acc1.reward_points_lost.to_i + @challenge.reward_points)
        else
           acc.update_attributes(reward_points_lost: acc.reward_points_lost.to_i + @challenge.reward_points)
           acc1.update_attributes(reward_points: acc1.reward_points.to_i + @challenge.reward_points.to_i)
        end  
      else
         # add reward points to winner and substract reward point from looser
        newlooser =   Account.find(@challenge.winner_id)  
        newwinner =   Account.find(params[:account_id])  
        
          newlooser.update_attributes(reward_points: newlooser.reward_points.to_i - @challenge.reward_points.to_i, reward_points_lost: newlooser.reward_points_lost.to_i + @challenge.reward_points.to_i)
          newwinner.update_attributes(reward_points: newwinner.reward_points.to_i + @challenge.reward_points.to_i, reward_points_lost: newwinner.reward_points_lost.to_i - @challenge.reward_points.to_i)
         
      
      end    
      #change status and add winner id into table
        abc =  @challenge.update_attributes(status: 'completed', winner_id: params[:account_id])        
       
      end
      
      if abc         
        render :json => cid  and return     
      else
        render :json => 0  and return     
      end
    end  
    
  end
  
# method to search user and show in drop down on new challenge/goals dropdown
	def search_user
	 if request.xhr?   
   
     uid = params[:uid].present? ? Base64.decode64(params[:uid]) : 0
	  if !params[:type].present?	
        @user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND accounts.id != #{@account.id} AND accounts.id != #{uid} AND accounts.user_type NOT IN (2,3)  AND (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")
        
    else
        @user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND  (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")  
    end
		 respond_to do |format|
       if params[:request_page] == 'post'
         format.js { render :partial => "/challenges/search_friend" }
       else
         format.js
       end
     end
    
	 end
	end 
def chall_params
    params.require(:challenge).permit(:qty, :text, :valid_till, :category_id, :reward_points)
  end



end
