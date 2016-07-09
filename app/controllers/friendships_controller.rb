class FriendshipsController < ApplicationController

  before_action :get_account  # will return @account 
  layout nil
   
def friend_request

  if request.xhr?   
	  from_id = @account.id	
	  to_id = Base64.decode64(params[:toid]) # this is the id of the user you want to become friend with
	  usr = Account.find_by_id(to_id)
	  if usr.user_type == 2
		friendable = Friendship.create(account_id: from_id, friend_id: to_id.to_i, approved: true)
	  else
	    friendable = Friendship.create(account_id: from_id, friend_id: to_id.to_i, approved: false)
	  end 	
	  
	  if friendable 
		render :json => params[:toid]  and return     
	  else
		render :json => 0  and return     
	  end
	  
	 
  end
end

def friend_request_cancel

  if request.xhr?   
	 
	  id = Base64.decode64(params[:id]) # this is the id of the user you want to become friend with		
	 
	  friendable = Friendship.where(account_id: @account.id, friend_id: id).first	  
	  friendable.destroy 
	  
	   if friendable 
		render :json => params[:toid]  and return      
	  else
		render :json => 0  and return     
	  end
  end
end

def friend_request_reject

  if request.xhr?   
	 
	  id = Base64.decode64(params[:id]) # this is the id of the user you want to delete friend with		
	 
	  friendable = Friendship.where(account_id: id, friend_id: @account.id).first	
	  if !friendable.present?
		 friendable = Friendship.where(account_id: @account.id, friend_id: id).first	
	  end
	  friendable.destroy 
	  
	   if friendable 
		render :json => params[:id]  and return      
	  else
		render :json => 0  and return     
	  end
  end
end


def friend_request_accept
  # accepting a friend request is done by the recipient of the friend request.
  # thus the current user is identified by to_id.
 if request.xhr?   
  id = Base64.decode64(params[:id])
  friendable = Friendship.where(account_id: id, friend_id: @account.id).first	  
  friendable.update_attributes(approved: true)
   if friendable 
		render :json => params[:toid]  and return      
	  else
		render :json => 0  and return     
	  end	
 end  
end





end # end of class
