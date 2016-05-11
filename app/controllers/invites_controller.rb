class InvitesController < ApplicationController
     before_action :get_account 
	def index
		@contacts = request.env['omnicontacts.contacts']
		respond_to do |format|
			format.html 
		end
	end
	
def send_invitations
    data = {'error' => true, 'msg' => 'Please Try Again'}
    contacts = params['contacts']   
    invity = []
    contacts.each do |email|
      if Account.where(:email => email).empty?
      
        invitee = Invitation.new(:invited_by => @account.id, :email => email)
        invity.push(email)
        invitee.save
      else
        data = {'error' => true, 'msg' => email + ' email already exist.'}
      end
    end
    if invity.present? and UserMailer.invite(invity,request, @account).deliver  #pass quote detail with 
      data['error'] = false
    end
    render :json => data
  end


end
