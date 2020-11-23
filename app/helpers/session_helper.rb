module SessionHelper
  def log_in(_user)
    session[:user_id] = user_id
  end

  def current_user
    @current_user ||= user.find_by(id: session[:user_id]) if session[:user_id]
  end
end
