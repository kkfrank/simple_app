class MicropostsController < ApplicationController
  before_action :logged_in_user,only:[:create,:destroy]

  before_action :correct_user,only:[:destroy]
  def create
    #debugger
    @micropost=current_user.microposts.build(micropost_params)
   # @micropost=Micropost.new(micropost_params)
  #  debugger
    if @micropost.save
      flash[:success]="Micropost created!"

      redirect_to root_url
    else
     # flash[:danger]="error"
      #redirect_to root_path
      @feed_items=[]
      render 'static_pages/home'
    end
  end

  def destroy
    #debugger
    #Micropost.find(params[:id]).destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    #debugger
    params.require(:micropost).permit(:content,:picture)
  end

  def correct_user
    debugger

    @micropost=current_user.microposts.find(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
