class CommentsController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  before_action :require_login
  before_action :find_commentable

  def create
    @comment = @commentable.comments.create(comments_params)
    if @comment.valid?
      @comment.save
    else
      flash[:danger] = @comment.errors.full_messages[0]
    end
    redirect_back fallback_location: root_path
  end

  private

  def comments_params
    params.require(:comment).permit(
      :body
    ).merge(user_id: current_user.id)
  end

  def find_commentable
    model = [Post, User].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = model.find(params["#{model.name.underscore}_id"])
  end
end
