class PostsController < ApplicationController
  include ApplicationHelper
  include SessionHelper
  before_action :current_user, only: %i[index show create]
  before_action :require_login, except: %i[index show]

  POST_PER_PAGE = 10

  def new
    @post = Post.new
  end

  def index
    current_page = current_page_params

    posts_plus_one = Post
      .order(vote: :desc, created_at: :desc)
      .offset(current_page * POST_PER_PAGE)
      .limit(POST_PER_PAGE + 1)
      .preload(:user)
      .select("posts.*, votes.value as vote_value")
      .joins("LEFT JOIN votes ON votes.user_id = #{logged_in? ? @current_user.id : -1} AND votes.voteable_id = posts.id AND votes.voteable_type = 'Post' ")

    if posts_plus_one.length <= POST_PER_PAGE
      @posts = posts_plus_one
      has_next = false
    else
      @posts = posts_plus_one.slice(0, POST_PER_PAGE)
      has_next = true
    end

    @page = {
      prev?: current_page.positive?,
      current: current_page,
      next?: has_next,
      last: ((Post.count - 1) / POST_PER_PAGE).to_i
    }
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
    @post = Post
      .find(params[:id])
    @post_vote = @post.votes.find_by(user_id: @current_user&.id)

    @comments = @post
      .comments
      .order(vote: :desc, created_at: :desc)
      .preload(:user)
      .select("comments.*, votes.value as vote_value")
      .joins("LEFT JOIN votes ON votes.user_id = #{logged_in? ? @current_user.id : -1} AND votes.voteable_id = comments.id AND votes.voteable_type = 'Comment' ")
    @comment = Comment.new
  end

  private

  def current_page_params
    params.fetch(:page, 0).to_i
  end

  def post_params
    params.require(:post).permit(
      :title,
      :body
    ).merge(user_id: @current_user.id)
  end
end
