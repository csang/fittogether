class GroupsController < ApplicationController
  before_filter :get_account
  
  def index
   
 
  end
  
#method that create new group
  def create
   
    @group = Group.create(group_parm.merge(:account_id => @account.id,  :activity_ids => params[:activity_ids]))

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
    if @group.update_attributes(group_parm.merge(:activity_ids => params[:activity_ids]))
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
      
      frnds =  get_frineds_ids(@account.id)      # friend ids of user    
      goings = GroupMember.where(:group_id => id).collect(&:account_id) # ids  of user already member
      frnd = frnds - goings #  ids of frnd that are not member
      @invite_able = Account.where("id IN  (?)", frnd)
      
      
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
      @member = GroupMember.where(:group_id=> id,:account_id =>@account.id).first
      if @member.present?
		if @member.update_attribute(:status, 1)
		   render :json => 1  and return     
		end
      else   
      @member = GroupMember.create(:group_id=> id,:account_id =>@account.id, :status => status)		
		  if @member.save
			render :json => 1  and return     
		  else
				render :json => 0  and return   
		  end 	
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
  
    def  group_cover
 
   if request.xhr?
  
		 @acc = GroupCover.where(:group_id => params[:gid], :position => params[:position] ).first
			if @acc.present?
				@acc.update_attribute(:cover, params[:cover])	
			else
				@acc = GroupCover.create(:group_id => params[:gid], :position => params[:position], :cover=> params[:cover]) 
			end
			if @acc.present?
				render :json => @acc.cover(:original)
			else
				render :json =>  @acc.errors.full_messages.first if @acc.errors.any?  
			end
					
		end
    end 
    
    def update_cover_offset
    
    if request.xhr?
			abc = params[:position_offset].map(&:inspect).join(',')
			abc.gsub!('"', '')
			@acc = GroupCover.where(:group_id => params[:gid], :position => params[:position] ).first
			if @acc.present?
				if @acc.update_attribute(:position_offset, abc)	
					render :json => 1
				else
				   render :json =>  @acc.errors.full_messages.first if @acc.errors.any?   
				end
			else
				render :json =>  @acc.errors.full_messages.first if @acc.errors.any?   
			end					
		end
    
    
    end 
    
    
  def invite_for_group
     if request.xhr?     
     gid = Base64.decode64(params[:group_id])   
     aid = Base64.decode64(params[:account_id])        
       @member = GroupMember.create(:group_id=> gid,:account_id =>aid, :status => 0)	
  
=begin  
		   met = email_settings(aid, 'group_invitation')
           if met.present? || met == 123 
            UserMailer.fitspot_invitation(@member.account.email,request, @account, @member).deliver
           end
=end           
            if @member.save
              render :json => 1  and return     
            else
              render :json => 0  and return   
            end 	
       
   else
      redirect_to('/feed')	 
   end
    
    
  end
    
  
  
  
  
  private
  
  def group_parm
    params.require(:group).permit(:title, :is_public, :group_image,:address, :description)


  end
  
end
