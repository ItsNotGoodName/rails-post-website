class CommentsController < ApplicationController
  include ApplicationHelper
  include SessionHelper
  before_action :require_login
  before_action :find_commentable

  def create
    @comment = @commentable.comments.create(comments_params)
    @comment.save
    goto_or_goback @comment.id
  end

  private

  def comments_params
    params.require(:comment).permit(
      :body
    ).merge(user_id: current_user.id)
  end

  def find_commentable
    model = [Post].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = model.find(params["#{model.name.underscore}_id"])
  end
end
