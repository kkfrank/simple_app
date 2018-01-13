class UsersController < ApplicationController
  def new
  # debugger
    @user=User.new
  end
  def show
    #debugger
    @user=User.find(params[:id])
  end

  def create
    #@user=User.new(params[:user])
    @user=User.new(user_params)
    if @user.save
      log_in @user
      flash[:success]="welcome to the Sample APp"
      redirect_to @user
      #redirect_to login_url
    else
      render "new"
    end
  end
  private

    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmatoinß)
    end
end
