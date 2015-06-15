class Admin::TasksController < ApplicationController

	def update
  
	   model = params[:model]	   
	   if !model.blank?
		   action = params[:action_type] 
		   scoped_model=model.constantize.where(:id => params[:task_ids])
				if ("Active" == action || "Inactive" == action )
					scoped_model.update_all(:status => (action=='Active') ? 1 : 0)
				elsif ('Delete' == action)
					scoped_model.destroy_all
				else
					abort("else")
				end
			if action=='Active'||action=='Inactive'
				flashVar = 'Status updated'.to_s
			end		
			if action=='Delete'
				flashVar = 'Record(s) has been deleted'.to_s
			end
			flash[:notice] = flashVar+' successfully';					
			redirect_to request.referer 
	 end	
	end

end
