module PostVotesHelper
  def vote_on_post(user, post, newvote)
    post_vote = PostVote.find_by(post_id: post.id, user_id: user.id)

    if post_vote.nil?
      # New voter
      PostVote.new(user_id: user.id, post_id: post.id, upvote: newvote).save
      post.increment!(:vote, newvote ? 1 : -1)
    elsif post_vote.upvote == newvote
      # Delete vote
      post_vote.destroy
      post.increment!(:vote, newvote ? -1 : 1)
    else
      # Change vote
      post_vote.upvote = newvote
      post_vote.save
      post.increment!(:vote, newvote ? 2 : -2)
    end
  end
end
