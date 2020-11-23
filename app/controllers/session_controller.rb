class SessionController < ApplicationController
  include SessionHelper
  def new; end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid credentials'
      render 'new'
    end
  end

  def destroy; end
end
