class SessionsController < ApplicationController
  def new
 #   debugger
    #debugger
  end

  def create#dneglu
    #debugger
    user=User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #debugger
      if user.activated?
        log_in user
        params[:session][:remember_me]=="1" ? remeber(user) : forget(user)
        #redirect_to user
        #redirect_to user_path(user)
        #debugger
        redirect_back_or(user)
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning]=message
        redirect_to root_url
      end

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
