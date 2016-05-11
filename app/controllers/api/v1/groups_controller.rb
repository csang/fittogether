class Api::V1::GroupsController < Api::V1::BaseController
  before_action :authenticate_with_token!
  before_action :check_post, :except => [:show, :edit]
   include ApplicationHelper
  
#method that create new group
  def create

    group = Group.create(group_parm.merge(account_id: current_user.id)) #group creater current user will be the admin of group
      if group.save!
       render :json => Base64.encode64(group.id.to_s) and return
      else		   
        render :json => group.errors.full_messages.first and return
      end 
  end
  
  def edit # can change title, image and is public/private
 
  if params[:group].present?
   cid = Base64.decode64(params[:id])		     
   group = Group.where(:id => cid,:account_id =>current_user.id).first
   if group.persent?
		if group.update_attributes(group_parm)
		 render :json => Base64.encode64(group.id.to_s) and return
	   else
		 render :json => group.errors.full_messages.first and return
 	   end
   else
 	 render :json => {errors: "No Such Group!"} 
   end   
  end
  
  
end

  def show

     if params[:id].present? #this is the id of group
		  id = Base64.decode64(params[:id])        
		  group = Group.where(:id => 1).first
		 
		  group_detail = Array.new  #group details plus group creater details will store in this array
		  user = get_user_array(group.account) #return only required details of user
		  acc = {}    
		  acc[:group] = group		
		  acc[:user] = user
		  group_detail.push(acc)		
		  
		  posts = group.post.sort_by{|e| -e[:id]} #sort post array by id
		  all_post = Array.new  #store post array with post owner as user , with comment and comment user  
		        
		  posts.each do |post|
		    user = get_user_array(post.account) 
		    acc = {}          						
		    acc[:post] = post			    
		    acc[:user] = user
		    acc[:comment] = {}	
		    acc[:comment][:user] = {}		
	           if post.comment.present?	          
				post.comment.each do |come|
				  acc[:comment][come.id] = come		
				   user = get_user_array(come.account)
		           acc[:comment][:user][come.id] = user			
				end				
		      end	
		       all_post.push(acc)  	#push hash into array
		  end
		  # group member with user detailsdetail
		  group_member = Array.new
		  group.group_member. each do |gm|
		     acc = {}          
		     acc[:member] = gm
		     acc[:user] = user
		     user = get_user_array(gm.account)
		     group_member.push(acc)
		  end
		  if !group.present?
				 render :json => {errors: "No Such Group!"} and return
		  else
		         render :json => {'group' => group_detail, 'posts' => all_post, 'member' => group_member}
		  end 
     else
       render :json => {errors: "No Such Group!"} and return
     end
    
  end
  # add new group member and remove member on click join and leave button
  def add_del_member
     id = Base64.decode64(params[:id])   
      if params[:type] =='add'       
         status = params[:gtype] == 'Private' ? 0 : 1 ;    #0 means admin needs to accept, 1 directly join public group
         member = GroupMember.create(:group_id=> id,:account_id =>current_user.id, :status => status)		
			  if member.save
				render :json => 1  and return     
			  else
				render :json => 0  and return   
			  end 	
      else
        member = GroupMember.where(:group_id=> id,:account_id =>current_user.id).first
        if member.present? && member.delete
        render :json => 1  and return     
      else
		render :json => 0  and return   
      end 	
     end
       
      
  end
  
 def create_group_post
  #abort(params.inspect)    
    if params[:group_id].present?
		gid = Base64.decode64(params[:group_id]) #id store into post table to identify group post from all post 
		#groupadmin = Group.find(gid)
		post =  Post.create(:account_id=>current_user.id,:text=>params[:post],:image=>params[:photo],:video=>params[:video], :status=>1,:group_id=>gid)	        
		if post.save!
			render :json => post.id  and return    
		else		   
			render :json => post.errors.full_messages  and return     
		end 
	else
	     render :json => {errors: "No Such Group!"} and return
	end	
    
  end
  
   def group_request    #accept / reject group join request
 
     id = Base64.decode64(params[:id])  # group memeber table primary key id
     member = GroupMember.find(id)
     if params[:type] =='accept'       
          if  member.update_attribute(:status, true)		
          render :json => 1  and return     
         else
          render :json => 0  and return   
         end 	
     else       
        if member.delete
         render :json => 1  and return     
       else
         render :json => 0  and return   
       end 	
     end
        
  
   end
    

  
  
  private
  
  def group_parm
    params.require(:group).permit(:title, :is_public, :group_image)
  end
  
end
