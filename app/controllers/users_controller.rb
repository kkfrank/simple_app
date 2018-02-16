class UsersController < ApplicationController

  before_action :logged_in_user,only:[:index,:show,:edit,:update]
  before_action :correct_user,only:[:show,:edit,:update]

  before_action :admin_user,only: :destroy
  def index
   # debugger
    #@users=User.all
    @users=User.paginate(page:params[:page])
  end

  def new
   debugger
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

  def edit
    @user=User.find(params[:id])
    #debugger
  end

  def update
   # debugger
   # binding.pry
    @user=User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success]="Profile updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
   # binding.pry
    User.find(params[:id]).destroy
    flash[:success]="User deleted"
    redirect_to users_path
  end

  def test
    render 'test'

  end
  private

    def user_params
      #debugger
      params.require(:user).permit(:name,:email,:password,:password_confirmation,:admin)
    end


    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger]="Please log in."
        redirect_to login_url
      end
    end

    def correct_user
     # debugger
      @user=User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
