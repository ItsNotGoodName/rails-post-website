module SessionHelper
  def log_in(user)
    session[:user_id] = user_id
  end

  def current_user
    if session[:user_id]
      @current_user ||= user.find_by(id: session[:user_id])
    end
end
