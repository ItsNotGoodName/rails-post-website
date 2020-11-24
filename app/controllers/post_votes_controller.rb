class PostVotesController < ApplicationController
  include SessionHelper
  before_action :require_login

  def create
    post_id = params[:post_id]
    upvote = params[:upvote].to_i == 1
    user = current_user
    post = Post.find_by id: post_id
    post_vote = PostVote.find_by(post_id: post_id, user_id: user.id)

    if post_vote.nil?
      # New voter
      PostVote.new(user_id: user.id, post_id: post_id, upvote: upvote).save
      upvote ? post.increment!(:vote) : post.decrement!(:vote)
    elsif post_vote.upvote == upvote
      # Delete vote
      post_vote.destroy
      upvote ? post.decrement!(:vote) : post.increment!(:vote)
    else
      # Change vote
      post_vote.upvote = upvote
      post_vote.save
      upvote ? post.increment!(:vote, 2) : post.decrement!(:vote, 2)
    end
    redirect_to root_path
  end
end
