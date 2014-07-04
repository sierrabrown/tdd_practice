class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?
  
  def log_in!(user)
    session[:session_token] = user.session_token
  end
  
  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end
  
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def signed_in?
    !!current_user
  end
  
  def authorize
    redirect_to new_session_url unless signed_in?
  end
end
