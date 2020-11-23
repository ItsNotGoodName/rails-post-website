module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= user.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in
    session[:user_id].nil?
  end
end
