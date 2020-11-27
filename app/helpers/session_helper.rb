module SessionHelper
  def login user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logout
    session[:user_id] = nil
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in'
      redirect_to login_path
    end
  end
end
