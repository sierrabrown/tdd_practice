class SessionsController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by_credentials(params[:email],params[:password])
    @user ||= User.new
    
    if @user
      log_in!(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end
  
  def destroy
    log_out!
    redirect_to new_session_url
  end
  
end
