class SessionsController < ApplicationController

  def new
    authorized_user = User.authenticate(params[:email], params[:password])
    if authorized_user
      session[:user_id] 	= authorized_user.id
      session[:last_seen] = Time.now()
      session[:user_name] = authorized_user.name
      flash[:notice] = "Hey there #{authorized_user.name}"
     # record_activity("Logged in")
      redirect_to(:controller => 'index', :action => 'index')
    else
      flash[:error] = "Invalid email/password combination."
      redirect_to(:controller => 'users', :action => 'sign_in')
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    session[:last_seen] = nil
    flash[:notice] = "Logged Out, See you soon!"
    redirect_to(:controller => 'users', :action => 'sign_in')
  end
end
