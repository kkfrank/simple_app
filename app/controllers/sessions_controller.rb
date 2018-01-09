class SessionsController < ApplicationController
  def new
    #debugger
  end

  def create
    user=User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      #redirect_to user
      #@user=user
      #render 'users/new'
      #redirect_to user_url(user)
      #redirect_to 'login'
      #debugger
      redirect_to user_path(user)
      #redirect_to "users/1"
    else
      flash.now[:danger]="Invalid email/password combination"
      render "new"
      #render text:"hello"
      #render :text=>"hello"
      #render :json => {text: "hello world!"}.to_json()
      #redirect_to(sessions:new)
      #debugger
    end

  end

  def destroy
    #debugger
    #session[:user_id]=nil
    log_out
    redirect_to root_path
    #redirect_to login_path
  end
end
