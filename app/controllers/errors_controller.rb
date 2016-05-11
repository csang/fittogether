class ErrorsController < ApplicationController
def error_404
    render_error 404
end

def error_500
    render_error 500
end

private
   def render_error(status)
       respond_to do |format|
           format.html { render 'error_' + status.to_s() + '.html', :status => status, :layout => 'application'}
           format.all { render :nothing => true, :status => status }
   end
end
end
