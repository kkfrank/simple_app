class SessionsController < ApplicationController
  def new
    #debugger
  end

  def create#dneglu
    user=User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me]=="1" ? remeber(user) : forget(user)
      #redirect_to user
      redirect_to user_path(user)
    else
      flash.now[:danger]="Invalid email/password combination"
      render "new"
    end

  end

  def destroy
    #debugger
    #session[:user_id]=nil
    log_out if logged_in?
    redirect_to root_path
    #redirect_to login_path
  end
end
