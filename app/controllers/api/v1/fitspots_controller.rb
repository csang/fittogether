class Api::V1::FitspotsController < Api::V1::BaseController
    before_action :authenticate_with_token!
    before_action :check_post, :except => [:show,:index,:edit] # check if request.post?
     include ApplicationHelper
  
   
  
  def index # show all fitspot
    
    render :json => {'fitspots' => Fitspot.all }
    
  end

  def create # request type should be post
   
      gid = Base64.decode64(params[:fitspot][:group_id])     # group id will be used in fitspot 
   
      fitspot = Fitspot.create(fitspot_parm.merge(account_id: current_user.id, :group_id => gid))
  
      if fitspot.save!
        if params[:invite].present? # to invite all group member for fitspot
          group_member =  GroupMember.where(:group_id => gid) # get group member
          if group_member.present?
            group_member.each do |gd|
              FitspotMember.create(:account_id => gd.account_id, :fitspot_id => fitspot.id) #crate fitspot member invitation
            end
          end  
        end
          render :json => 1 and return
      else		   
        render :json => { errors: fitspot.errors.full_messages  }    
      end 
      
   
  end
  
  def edit # request type should be put
 
  if params[:fitspot].present? # fitspot top node of array
     cid = Base64.decode64(params[:id])		# primery key of fitspot     
     fitspot = Fitspot.where(:id => cid,:account_id =>current_user.id).first
    if fitspot.present?
		if fitspot.update_attributes(fitspot_parm)
		  render :json => 1 and return
	   else
		  render :json => { errors: fitspot.errors.full_messages.first  }  
	   end
	else
	    render :json => {errors: "No Such Fitspot!"} 
	end   
  end
  
  
end

  def show # get fitspot detail
  
     if params[:id].present?
		  id = Base64.decode64(params[:id])     #decode fitspot id     
		  fitspot = Fitspot.find_by_id(id)      
		  going = FitspotMember.where(:fitspot_id => id, :account_id => current_user.id, :status => true).first
		  # goings = FitspotMember.where(:fitspot_id => id).collect(&:account_id)
		  goings = Array.new
		  fitspot.fitspot_member.each do |fm|
		    user =  get_user_array(fm.account)
		    goings.push(user)
		  end
		  
		  if goings.present?
		  inviteable = GroupMember.where("group_id = ? && account_id NOT IN (?)" ,fitspot.group_id, goings)
		  #inviteables = GroupMember.where("group_id = ? && account_id NOT IN (?)" ,fitspot.group_id, goings).collect(&:account_id)
		  else
		  inviteable = GroupMember.where("group_id = ? " ,  fitspot.group_id)
		  #inviteables = GroupMember.where("group_id = ? " , fitspot.group_id).collect(&:account_id)
		  end
		  user = get_friend_and_member(current_user, goings) 
		render :json => {'fitspot' => fitspot,'goings' =>goings ,'friend_member' => user, 'inviteable' => inviteable}  
     else 
        render :json => {errors: "No Such Fitspot!"} 
     end
     
  end
  
  def add_del_going # add delete event going 
    
  
     id = Base64.decode64(params[:id])   #param fitspot id required to find fitspot member of that fitspot
     if params[:type] =='add'        #params add   
        member = FitspotMember.where(:fitspot_id=> id,:account_id => current_user.id).first #check existing row to update status
        if member.present?
          if  member.update_attribute(:status, true)
              render :json => 1  and return     
          else
              render :json => 0  and return   
          end 	
        else # if memebe not present then create new
        member = FitspotMember.create(:fitspot_id=> id,:account_id => current_user.id, :status => true, :seen => true)		
            if member.save
              render :json => 1  and return     
            else
              render :json => 0  and return   
            end 	
        end  
     else # if not add that delete
        member = FitspotMember.where(:fitspot_id=> id,:account_id =>current_user.id).first
        if member.delete
           render :json => 1  and return     
      else
		   render :json => 0  and return   
      end 	
     end
        
 
    
  end
  
   def invite_for_fitspot
    
     fid = Base64.decode64(params[:fitspot_id])   
     aid = Base64.decode64(params[:account_id])        
     member = FitspotMember.where(:fitspot_id=> fid,:account_id =>aid)
     if !member.present?
		 member = FitspotMember.create(:fitspot_id=> fid,:account_id =>aid)		
		 met = email_settings(aid, 'group_invitation')
		   if met.present? || met == 123 
			if !UserMailer.fitspot_invitation(member.account.email,request, current_user, member).deliver
			  render :json => 0  and return   
			end  
		   end
			if member.save
			  render :json => 1  and return     
			else
			  render :json => 0  and return   
			end 	
	else
	  render :json => {errors: "Already going!"}  and return   
	end		
           
  end
  
  
 private  
  def fitspot_parm
    params.require(:fitspot).permit(:title, :description, :fitspot_image, :location, :fitspot_date, :fitspot_time)

  end
end
