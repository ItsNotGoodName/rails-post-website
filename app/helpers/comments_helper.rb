module CommentsHelper
  def get_comments(commentable)
    commentable
      .comments
      .order(vote: :desc, created_at: :desc)
      .paginate(page: page_param)
      .preload(:user)
      .with_vote_value @current_user
  end
end
