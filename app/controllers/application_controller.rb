class ApplicationController < ActionController::Base
  # methods are available in all controllers
  
  helper_method :curr_user, :logged_in? # this method is also available in views

  def curr_user
    @curr_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!curr_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to continue"
      redirect_to login_path
    end
  end
end
