class CommentsController < ApplicationController
  include SessionHelper
  before_action :require_login
  before_action :find_commentable

  def create
    @comment = Comment.new(comments_params)
    if @comment.save
      goto_or_goback @commentable.id
    else
      render :root_path
    end
  end

  private

  def comments_params
    params.require(:comments).permit(
      :body
    ).merge(user_id: current_user.id)
  end

  def find_commentable
    model = [Post].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = model.find(params["#{model.name.underscore}_id"])
  end
end
