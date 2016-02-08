class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    unless current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end
  
  def restrict_admin
    unless admin_user
      flash[:alert] = "You must be an admin to view that page."
      redirect_to movies_path
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_user
    @admin_user ||= User.find(session[:admin_user_id]) if session[:admin_user_id]
  end

  def admin_logged_in?
    current_user && admin_user
  end

  def admin_viewing_as_user?
    current_user != admin_user
  end

  helper_method :current_user, :admin_logged_in?, :admin_viewing_as_user?

end