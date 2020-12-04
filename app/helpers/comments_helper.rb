module CommentsHelper
  def comments_for(commentable, user)
    commentable
      .comments
      .order(vote: :desc, created_at: :desc)
      .paginate(page: page_param)
      .preload(:user)
      .with_vote(user)
  end
end
