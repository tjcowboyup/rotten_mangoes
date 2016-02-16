class SessionsController < ApplicationController
 
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:admin_user_id] = user.id if user.is_admin == true      
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"    
    else
      flash.now[:alert] = "Log in failed!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:admin_user_id] = nil if session[:admin_user_id]    
    redirect_to movies_path, notice: "Ciao!"
  end
    
end
