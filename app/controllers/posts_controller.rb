class PostsController < ApplicationController
  include ApplicationHelper
  include SessionHelper
  before_action :require_login, except: %i[index show]

  POST_PER_PAGE = 10

  def new
    @post = Post.new
  end

  def index
    current_page = current_page_params

    posts_plus_one = Post
      .order(created_at: :desc)
      .offset(current_page * POST_PER_PAGE)
      .limit(POST_PER_PAGE + 1)
      .preload(:user)

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
    ).merge(user_id: current_user.id)
  end
end
