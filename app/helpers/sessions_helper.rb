module SessionsHelper
  def log_in(user)
    session[:user_id]=user.id
  end
  def log_out
    forget current_user
    session.delete(:user_id)
    @current_user=nil
  end
  def remeber(user)
    user.remember
    cookies.permanent.signed[:user_id]=user.id
    #cookies.permanent[:user_id]=user.id
    cookies.permanent[:remember_token]=user.remember_token
  end
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  def current_user
    if session[:user_id]
      @current_user ||=User.find_by(id:session[:user_id])
    elsif cookies.signed[:user_id]
      debugger
      user=User.find_by(id:cookies.signed[:user_id])
      if user && user.authenticated?(:remember,cookies[:remember_token])
        log_in user
        @current_user=user
      end
    end
    #debugger
  end
  def logged_in?
    #!session[:user_id].nil?
    !current_user.nil?
  end

  def current_user?(user)
   #debugger
    user==current_user
  end

  def store_location
    session[:forwarding_url]=request.original_url if request.get?

  end

  def redirect_back_or(default)
  #  debugger
    redirect_to (session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

end
