class ChallengesController < ApplicationController
  before_filter :get_account
 
  def create
  
  
    if request.xhr?  
      to_id = Base64.decode64(params[:to_id])
        #abort(params[:valid_till].inspect)
      @challenge = Challenge.create(:category_id=> params[:category_id],
		 		:account_id =>@account.id,:to_id=> to_id,:text=>params[:text],:reward_points => params[:reward_points],:qty=>params[:qty],:valid_till=>params[:valid_till])
			
		
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

    @allchallenge = Challenge.involving(@account.id).order('id desc').paginate(:page => params[:page], :per_page =>15)	
    
    chl = Challenge.where(to_id: @account.id) 
    if chl.present?
      chl.each do |ff|
        ff.update_attributes(is_read: true)
      end
    end	

  end
  
  

  def show
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
  #abort(@challenge.inspect)
 # abort(params.inspect)
  if params[:challenge].present?
    if @challenge.update_attributes(chall_params)
     flash[:notice] = 'Challenge was successfully updated.'
     redirect_to(@challenge)
   else
     render "edit"
   end
  end
  
  
end

def chall_params
    params.require(:challenge).permit(:qty, :text, :valid_till, :category_id, :reward_points)
  end


	def search_user
	 if request.xhr?   
	  if !params[:type].present?	
        @user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND accounts.id != #{@account.id} AND (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")
        
    else
        @user =Account.joins("LEFT JOIN account_gyms ON accounts.id = account_gyms.account_id").where("accounts.status = 1 AND  (lower(accounts.first_name) LIKE ? OR lower(accounts.last_name) LIKE ? OR lower(accounts.email) LIKE ? OR lower(accounts.user_name) LIKE ? OR lower(account_gyms.name) LIKE ?)", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%")  
    end
		 respond_to do |format|
      format.js       
     end
    
	 end
	end 

end
