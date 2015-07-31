class FitspotsController < ApplicationController
   before_filter :get_account
   
  
  def index
    
    @fitspots = Fitspot.all
    
  end

  def create
   
      gid = Base64.decode64(params[:fitspot][:group_id])
      
      @fitspot = Fitspot.create(fitspot_parm.merge(account_id: @account.id, :group_id => gid))
  
      if @fitspot.save!
        if params[:invite].present?
          group_member =  GroupMember.where(:group_id => gid)
          if group_member.present?
            group_member.each do |gd|
              FitspotMember.create(:account_id => gd.account_id, :fitspot_id => @fitspot.id)
            end
          end  
        end
          flash[:notice] = "New Fitspot has been succesfully created."
           redirect_to("/fitspots/" + Base64.encode64(@fitspot.id.to_s)) and return
      else		   
        flash[:error] = @group.errors.full_messages  
         redirect_to request.env['HTTP_REFERER'] and return
      end 
      
   
  end
  
  def edit
 
  if params[:fitspot].present?
     cid = Base64.decode64(params[:id])		     
     @fitspot = Fitspot.where(:id => cid,:account_id =>@account.id).first
    if @fitspot.update_attributes(fitspot_parm)
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
  
  
 private  
  def fitspot_parm
    params.require(:fitspot).permit(:title, :description, :fitspot_image, :location, :fitspot_date, :fitspot_time)

  end
end
