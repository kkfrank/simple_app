class PasswordResetsController < ApplicationController
  before_action :get_user,only: [:edit,:update]
  before_action :valid_user,only: [:edit,:update]
  before_action :check_expiration,only: [:edit,:update]
  def new
  end

  def create

    @user=User.find_by(email:params[:password_reset][:email].downcase)
    if @user
      #debugger
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info]="Email sent with password reset instructions"
      redirect_to root_path
    else
      debugger
      flash.now[:danger]="Email address not found"
      #flash[:danger]="Email address not found"
      render 'new'
    end

  end

  def edit

    #@user=User.find_by(email:params[:email].downcase)
    #debugger
   # redirect_to root_path unless (@user && @user.activated? && @user.authenticated?('reset',@user.reset_token))
    #redirect_to root_path unless (@user && @user.activated? && @user.authenticated?('reset',params[:id]))
  end

  def update
    #debugger
    if params[:user][:password].blank?#empty?
      @user.errors.add(:password, "can't be empty")
      #flash[:success]="update success"
      #redirect_to edit_password_reset_url(params[:id],email:params[:email])
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
     # @user.update_attribute(:reset_digest,nil)

      flash[:success]="update success"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def get_user
    @user=User.find_by(email:params[:email])
  end

  def valid_user
    redirect_to root_path unless (@user && @user.activated? && @user.authenticated?('reset',params[:id]))
  end

  def user_params
    params.require(:user).permit(:password,:password_confirmation)
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:error]="Password reset has expired."
      redirect_to new_password_reset_path
    end
  end
end
