# Controller to manage users
class Admin::AccountsController < ApplicationController
  # include AccountsHelper
  before_filter :authenticate_admin!
  layout "admin"

 
  # List all the users
  def index
    @users = Account.order('first_name').paginate(page: params[:page], per_page: 10)
  end
  
  # Show details 
  def show
    @user = Account.find(params[:id])
    if !@user.blank?	
      respond_to do |format|
        format.html
        format.json { render json: @user }
      end
    else
      redirect_to action: 'index'
    end
    
  end

  # Create a new user
  def new
    @user = Account.new
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  # Edit a user
  def edit
    @user = Account.find(params[:id])
    render 'edit'
  end

  # Update status
  def status
    @id = params[:id].to_i
    @model = params[:model].to_s
    @status = params[:status].to_i
    if !@id.blank?
      status_method(@id, @model, @status)  #method define in app controller
      #render :json => '1' and return 
    end
  end

  # Update a existing user
  def update
    @user = Account.find(params[:id])
    if @user.update_attributes(:first_name => params[:account][:first_name],:last_name => params[:account][:last_name],:user_name => params[:account][:user_name],:account_url => params[:account][:account_url],:profession_id => params[:account][:profession_id],:company => params[:account][:company],:industry_id => params[:account][:industry_id],:gym_id => params[:account][:gym_id],:status => params[:account][:status],:goals => params[:account][:goals])
      redirect_to admin_accounts_url, notice: 'User details has been updated successfully.'
    else
      redirect_to request.env['HTTP_REFERER'] and return
    end
  end

  # Delete a user
  def destroy
    @user = Account.where(:fit_id => params[:dataId]).first
    
    respond_to do |format|
      if @user.destroy
        format.json { render :json=>'1' and return }
      else
        format.json { render :json=>'0' and return }
      end 
    end
  end
  
  # Delete a user
  def delete_user
    if(request.xhr?)
      @user = Account.where(:fit_id => params[:dataId]).first
    end
  end
  
  def search

      @users = Account.where("lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(email) LIKE ?", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%" ).paginate(
        page: params[:page])
	end
	
	def set_status
		abort(params.inspect)
	end
	
	# List based on type of users
  def listUsers   
         case params[:type].to_s
          when 'trainer'
            @model = AccountTrainer
          when 'gym'  
            @model = AccountGym
          when 'user'  
            @model = AccountUser
          else
           @model = AccountUser
          end
      @users =  Account.where(:id =>  @model.all.select(:account_id) ).order('first_name').paginate(page: params[:page], per_page: 10)
      render :index
  end
 
end
