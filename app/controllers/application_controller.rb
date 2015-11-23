class ApplicationController < ActionController::Base
  protect_from_forgery

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :current_user

  protected
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end   

  def authenticate_user!    
    if current_user.nil?
      redirect_to root_path and return
    end
  end
end
  
