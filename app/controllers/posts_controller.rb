class PostsController < ApplicationController
  include ApplicationHelper
  include SessionHelper
  before_action :current_user, only: %i[index show]
  before_action :require_login, except: %i[index show]

  POST_PER_PAGE = 10

  def new
    @post = Post.new
  end

  def index
    @posts = Post
      .order(vote: :desc, created_at: :desc)
      .paginate(page: current_page_params, per_page: 2)
      .preload(:user)
      .with_vote_value @current_user
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_vote = @post.votes.find_by(user: @current_user)
    @comments = @post
      .comments
      .order(vote: :desc, created_at: :desc)
      .paginate(page: current_page_params)
      .preload(:user)
      .with_vote_value @current_user
  end

  private

  def current_page_params
    params.fetch(:page, 1).to_i
  end

  def post_params
    params.require(:post).permit(
      :title,
      :body
    ).merge(user_id: @current_user.id)
  end
end
