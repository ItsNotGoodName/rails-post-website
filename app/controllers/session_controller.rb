class SessionController < ApplicationController
  include SessionHelper
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user&.authenticate(params[:session][:password])
      login user
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid credentials"
      render "new"
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
