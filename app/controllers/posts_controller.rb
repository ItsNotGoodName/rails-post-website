class PostsController < ApplicationController
  include SessionHelper
  before_action :require_login, except: %i[index show]

  POST_PER_PAGE = 10

  def new
    @post = Post.new
  end

  def index
    current_page = current_page_params

    if logged_in?
      posts_plus_one = Post
                       .order(created_at: :desc)
                       .offset(current_page * POST_PER_PAGE)
                       .limit(POST_PER_PAGE + 1)
                       .select('posts .*, post_votes.upvote as upvote')
                       .joins("LEFT JOIN post_votes ON post_votes .user_id = #{current_user.id} AND post_votes.post_id = posts.id")
    else
      posts_plus_one = Post
                       .order(created_at: :desc)
                       .offset(current_page * POST_PER_PAGE)
    end
    has_next = true

    if posts_plus_one.length <= POST_PER_PAGE
      @posts = posts_plus_one
      has_next = false
    else
      @posts = posts_plus_one.slice(0, POST_PER_PAGE)
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
      render 'new'
    end
  end

  def show
    @post = Post.find_by id: params[:id]
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
