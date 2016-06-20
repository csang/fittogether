class FitspotsController < ApplicationController
   before_filter :get_account
   
  
  def index    
    @fitspots = Fitspot.all    
  end

  def create	
      #gid = Base64.decode64(params[:fitspot][:group_id])      
      @fitspot = Fitspot.create(fitspot_parm.merge(account_id: @account.id,:activity_ids => params[:activity_ids]))  
      if @fitspot.save!
=begin
        if params[:invite].present?
          group_member =  GroupMember.where(:group_id => gid)
          if group_member.present?
            group_member.each do |gd|
              FitspotMember.create(:account_id => gd.account_id, :fitspot_id => @fitspot.id)
            end
          end  
        end
=end
	   flash[:notice] = "New Fitspot has been succesfully created."
	   redirect_to("/fitspots/" + Base64.encode64(@fitspot.id.to_s)) and return
      else		   
       flash[:error] = @fitspot.errors.full_messages  
       redirect_to request.env['HTTP_REFERER'] and return
      end        
  end
  
def edit 
  if params[:fitspot].present?
     cid = Base64.decode64(params[:id])		     
     @fitspot = Fitspot.where(:id => cid,:account_id =>@account.id).first
    if @fitspot.update_attributes(fitspot_parm.merge(:activity_ids => params[:activity_ids]))
     flash[:notice] = 'Fitspot has been updated successfully.'
       redirect_to("/fitspots/" + Base64.encode64(@fitspot.id.to_s)) and return
   else
     redirect_to request.env['HTTP_REFERER'] and return
   end
  end 
end

  def show
      if params[:id].present?
      id = Base64.decode64(params[:id])    
      
      @fitspot = Fitspot.where(:id => id).first        
      @going = FitspotMember.where(:fitspot_id => id, :account_id => @account.id, :status => true).first
      @goings = FitspotMember.where(:fitspot_id => id).collect(&:account_id)
    
      if @goings.present?
      @inviteable = GroupMember.where("group_id = ? && account_id NOT IN (?)" ,@fitspot.group_id, @goings)
      @inviteables = GroupMember.where("group_id = ? && account_id NOT IN (?)" ,@fitspot.group_id, @goings).collect(&:account_id)
      else
       @inviteable = GroupMember.where("group_id = ? " ,@fitspot.group_id)
       @inviteables = GroupMember.where("group_id = ? " ,@fitspot.group_id).collect(&:account_id)
      end
      
        #@groups = GroupMember.where("account_id !=? ",  @account.id).group('group_id')
        @groups = GroupMember.find_by_sql("SELECT * FROM `group_members` WHERE `group_id` NOT IN 
        (SELECT `group_id` FROM `group_members`WHERE `account_id` = #{@account.id})")
		
        @posts = Post.where(:status=>1, :group_id => id).order("id DESC")
         @member = GroupMember.where(:group_id => @fitspot.group_id, :account_id => @account.id).first
       
      flash[:error] =''
      if !@fitspot.present?      
          redirect_to('/feed')
      end         
        @profile = 'feed'
      else 
      redirect_to('/feed')
    end
  end
  
  def add_del_going
    
   if request.xhr?  
   
     id = Base64.decode64(params[:id])   
     if params[:type] =='add'         
        @member = FitspotMember.where(:fitspot_id=> id,:account_id =>@account.id).first
        if @member.present?
          if  @member.update_attribute(:status, true)
             render :json => 1  and return     
         else
           render :json => 0  and return   
         end 	
        else
        @member = FitspotMember.create(:fitspot_id=> id,:account_id =>@account.id, :status => true, :seen => true)		
            if @member.save
              render :json => 1  and return     
            else
              render :json => 0  and return   
            end 	
        end  
     else
        @member = FitspotMember.where(:fitspot_id=> id,:account_id =>@account.id).first
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
  
   def invite_for_fitspot
    
   if request.xhr?  
   
     fid = Base64.decode64(params[:fitspot_id])   
     aid = Base64.decode64(params[:account_id])   
     
       @member = FitspotMember.create(:fitspot_id=> fid,:account_id =>aid)		
       met = email_settings(aid, 'group_invitation')
           if met.present? || met == 123 
            UserMailer.fitspot_invitation(@member.account.email,request, @account, @member).deliver
           end
            if @member.save
              render :json => 1  and return     
            else
              render :json => 0  and return   
            end 	
       
   else
      redirect_to('/feed')	 
   end
    
    
  end
  
  def  fitspot_cover
 
   if request.xhr?
		 @acc = FitspotCover.where(:fitspot_id => params[:fit], :position => params[:position] ).first
			if @acc.present?
				@acc.update_attribute(:cover, params[:cover])	
			else
				@acc = FitspotCover.create(:fitspot_id => params[:fit], :position => params[:position], :cover=> params[:cover]) 
			end
			if @acc.present?
				render :json => @acc.cover(:original)
			else
				render :json =>  @acc.errors.full_messages.first if @acc.errors.any?  
			end
					
		end
    end 
    
    
   def fitspot_check_in
      
     
	  check_in = FitspotCheckin.create(checkin_params.merge(account_id: @account.id))	
      if check_in.save!  
        text = "#{@account.first_name} checked in at #{params[:location]}"
        @posts =  Post.create(:account_id=>@account.id,:text=>text,:status=>1,:share_with=> 'Public', :post_type => 'checkin' ,:group_id => params[:fitspot_id] )	         
        render :json => 1  and return     
      else
		render :json => 0  and return   
      end 	
  
  end
  
   def update_fitspot_cover_offset
    
    if request.xhr?
			abc = params[:position_offset].map(&:inspect).join(',')
			abc.gsub!('"', '')
			@acc = FitspotCover.where(:fitspot_id => params[:fid], :position => params[:position] ).first
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
    
    
def fitspot_request    
if request.xhr?  
	id = Base64.decode64(params[:id])  
	@member = FitspotMember.find(id)
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
  def fitspot_parm
    params.require(:fitspot).permit(:title, :description, :fitspot_image, :location)

  end
   def checkin_params
    params.permit(:location, :fitspot_id)
  end 
end
