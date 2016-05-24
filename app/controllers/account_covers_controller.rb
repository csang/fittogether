class AccountCoversController < ApplicationController
  before_filter :get_account
  def new
  end

  def create
    if request.xhr?
		 @acc = AccountCover.where(:account_id => @account.id, :position => params[:position] ).first
			if @acc.present?
				@acc.update_attribute(:cover, params[:cover])	
			else
				@acc = AccountCover.create(:account_id => @account.id, :position => params[:position], :cover=> params[:cover]) 
			end
			if @acc.present?
				render :json => @acc.cover(:medium)
			else
				render :json =>  @acc.errors.full_messages.first if @acc.errors.any?  
			end
					
		end
    end 

end
