module Authenticable


  def current_user
      @account ||= Account.find_by(fit_id: request.headers['Authorization'])
  end
  
  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

end #end of module
