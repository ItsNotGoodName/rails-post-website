class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid credentials'
      render 'new'
    end
  end

  def destroy; end
end
