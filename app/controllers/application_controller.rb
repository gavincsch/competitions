class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'users', :action => 'sign_in')
      return false # halts the before_filter
    else
      unless session[:last_seen] > 100.minutes.ago
        reset_session
        flash[:notice] = "session expired please log in."
        redirect_to(:controller => 'users', :action => 'sign_in')
        return false # halts the before_filter
      else
        @userAuthenticated  = User.find(session[:user_id])
        session[:last_seen] = Time.now
        return true
      end
    end
  end


  def current_user
    unless session[:user_id]
      return false
    else
      return true
    end
  end

  def is_admin
    unless session[:user_id]
      return false
    else
      @currentUser = User.find(session[:user_id])
      @isAdmin =  @currentUser.admin
    end
  end
end


