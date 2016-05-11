class GroupsController < ApplicationController
  before_filter :get_account
  
  def index
   
 
  end
  
#method that create new group
  def create
  
    @group = Group.create(group_parm.merge(account_id: @account.id))
  
      if @group.save!
          flash[:notice] = "New Group has been successfully created."
           redirect_to("/groups/" + Base64.encode64(@group.id.to_s)) and return
      else		   
        flash[:error] = @group.errors.full_messages  
         redirect_to request.env['HTTP_REFERER'] and return
      end 
      
   
    
  end
  
  def edit
 
  if params[:group].present?
   cid = Base64.decode64(params[:id])		     
  @group = Group.where(:id => cid,:account_id =>@account.id).first
    if @group.update_attributes(group_parm)
     flash[:notice] = 'Group has been updated successfully .'
       redirect_to("/groups/" + Base64.encode64(@group.id.to_s)) and return
   else
     redirect_to request.env['HTTP_REFERER'] and return
   end
  end
  
  
end

  def show
   
     if params[:id].present?
      id = Base64.decode64(params[:id])    
      
      @group = Group.where(:id => id).first
      @posts = Post.where(:status=>1, :group_id => id).order("id DESC")
      @member = GroupMember.where(:group_id => id, :account_id => @account.id).first
      
      flash[:error] =''
      if !@group.present?
         # flash[:error] = "Page you are looking does not exist."
          redirect_to('/feed')
      end 
        
        @profile = 'feed'
    else 
      redirect_to('/feed')
    end
    
  end
  
  def add_del_member
    
   if request.xhr?  
   
     id = Base64.decode64(params[:id])   
     if params[:type] =='add'  
       
      status = params[:gtype] == 'Private' ? 0 : 1 ;
    
      @member = GroupMember.create(:group_id=> id,:account_id =>@account.id, :status => status)		
      if @member.save
        render :json => 1  and return     
      else
		    render :json => 0  and return   
      end 	
     else
        @member = GroupMember.where(:group_id=> id,:account_id =>@account.id).first
        if @member.delete
        render :json => 1  and return     
      else
		    render :json => 0  and return   
      end 	
     end
        
   else
      redirect_to('/feed')	 
   end
    
    
  end
  
    def create_group_post
  #abort(params.inspect)
   if request.xhr?   
    gid = Base64.decode64(params[:group_id])
    @groupadmin = Group.find(gid)
    @post =  Post.create(:account_id=>@account.id,:text=>params[:post],:image=>params[:photo],:video=>params[:video], :status=>1,:group_id=>gid)	        
      respond_to do |format|
      if @post.save!
           format.js
      else
		   
        render :json => @post.errors.full_messages  and return     
      end 
   end
		  
	end
  
  end
  
   def group_request
    
   if request.xhr?  
   
     id = Base64.decode64(params[:id])  
     @member = GroupMember.find(id)
     if params[:type] =='accept'       
  
        if  @member.update_attribute(:status, true)		
          render :json => 1  and return     
        else
          render :json => 0  and return   
        end 	
     else       
        if @member.delete
         render :json => 1  and return     
       else
         render :json => 0  and return   
       end 	
     end
        
   else
      redirect_to('/feed')	 
   end
    
    
  end
  
  
  
  
  private
  
  def group_parm
    params.require(:group).permit(:title, :is_public, :group_image)


  end
  
end
