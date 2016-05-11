class Admin::SessionsController < ::Devise::SessionsController
  layout "admin"
  # the rest is inherited, so it should work
  def create
    super
  end
  def destroy
	  set_flash_message(:notice, :signed_out) if is_navigational_format?
    sign_out :admin
    redirect_to new_admin_session_path and return
  end
  
  def after_sign_in_path_for(resource)
   "/admin/dashboard/" #adjust the returned path as needed
  end  
end
