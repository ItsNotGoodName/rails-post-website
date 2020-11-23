class PostsController < ApplicationController
  include SessionHelper
  before_action :require_login, except: %i[index show]

  def new
    @post =  Post.new
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find_by id: params[:id]
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :body
    ).merge(user_id: current_user.id)
  end
end
