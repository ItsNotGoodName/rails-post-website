class UsersController < ApplicationController
  include SessionHelper

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    render file: "public/404.html" if @user.nil?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :password,
      :password_confirmation
    )
  end
end
