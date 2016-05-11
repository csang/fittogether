class Admin::RegistrationsController < ::Devise::RegistrationsController
layout "admin"

def new()
  redirect_to "/admin/dashboard/" and return
  end 
  
protected

    def after_update_path_for(resource)
      "/admin/dashboard/" #adjust the returned path as needed
    end   
end

