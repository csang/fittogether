class Api::V1::FriendshipsController < Api::V1::BaseController

  before_action :authenticate_with_token!
  include ApplicationHelper
   
def friend_request

  if request.post?   
 	  to_id = Base64.decode64(params[:to_id]) # this is the id of the user you want to become friend with
	  already_friend = Friendship.if_already(to_id,current_user.id)
	  if already_friend.present?
	      render :json => {errors: "already Friend"} and return
	  else    
		 if Friendship.create(account_id: current_user.id, friend_id: to_id.to_i, approved: false)	  
		
			render :json => 1   
		  else
			render :json => friendable.errors.full_messages.first    
		  end
	  end
	 
  end
end

def friend_request_cancel

  if request.post?   
	 
	  id = Base64.decode64(params[:to_id]) # this is the id of the user you want to become friend with			 
	  friendable = Friendship.where(account_id: current_user.id, friend_id: id).first	    
	   if friendable.present?
		   if friendable.destroy  
			render :json => 1  and return      
		  else
			render :json => friendable.errors.full_messages.first    
		  end
		else
		    render :json => {errors: "No Friendship Present"}
		end  
  end
end
# don't confuse with reject word, method is for remove  friend
def friend_request_reject

  if request.post?   

	  id = Base64.decode64(params[:id]) # this is the id of the user you want to delete friend with		
	 
	  friendable = Friendship.where(account_id: id, friend_id: current_user.id).first	# request received
	  if !friendable.present?
		 friendable = Friendship.where(account_id: current_user.id, friend_id: id).first	# request send
	  end
	   if friendable.present?
		   if friendable.destroy  
			render :json => 1  and return      
		  else
			render :json =>  friendable.errors.full_messages.first     and return     
		  end
	   else
		    render :json => {errors: "No Friendship Present"}
		end 	  
  end
end

#put request
def friend_request_accept
  # accepting a friend request is done by the recipient of the friend request.
  # thus the current user is identified by current_user.id.
  
 if request.put?   
  id = Base64.decode64(params[:id])
  friendable = Friendship.where(account_id: id, friend_id: current_user.id).first	  
  if friendable.present?
     if friendable.update_attributes(approved: true) 
		render :json => 1  and return      
	  else
		render :json => friendable.errors.full_messages.first  and return      
	  end	
  else
	   render :json => {errors: "No Friendship Present"}
  end   
 end  
end





end # end of class
