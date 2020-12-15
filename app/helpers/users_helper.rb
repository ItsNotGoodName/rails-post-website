module UsersHelper
  def get_total_votes user
    Comment.where(user_id: @user.id).sum(:vote) + Post.where(user_id: @user.id).sum(:vote)
  end
end
