class UsersController < ApplicationController
  include ApplicationHelper
  include CommentsHelper
  include SessionsHelper
  include UsersHelper
  before_action :current_user, only: %i[show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @comments = comments_for @user, @current_user
    @total_votes = get_total_votes @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      flash[:success] = "Successfully registered and logged in"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :password,
      :password_confirmation
    )
  end
end
