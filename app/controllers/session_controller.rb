class SessionController < ApplicationController
  def new; end

  def create
    debugger
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy; end
end
