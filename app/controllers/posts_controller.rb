class PostsController < ApplicationController
  include ApplicationHelper
  include CommentsHelper
  include SessionsHelper
  before_action :current_user, only: %i[index show create]
  before_action :require_login, except: %i[index show]

  POST_PER_PAGE = 10

  def new
    @post = Post.new
  end

  def index
    @posts = Post
      .order(vote: :desc, created_at: :desc)
      .paginate(page: page_param)
      .preload(:user)
      .with_vote(@current_user)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post submitted"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post
      .where(params[:id])
      .with_vote(@current_user)
      .limit(1)
      .first
    @comments = comments_for(@post, @current_user)
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :body
    ).merge(user_id: @current_user.id)
  end
end
