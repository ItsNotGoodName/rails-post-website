class PostVotesController < ApplicationController
  include SessionHelper
  before_action :require_login

  def vote
    post_id = params[:post_id]
    upvote = params[:upvote].to_i == 1
    user = current_user
    post_vote = PostVote.find_by(post_id: post_id, user_id: user.id)

    if post_vote.nil?
      # New voter
      PostVote.new(user_id: user.id, post_id: post_id, upvote: upvote).save
      upvote ? Post.find(post_id).increment!(:vote) : Post.find(post_id).decrement!(:vote)
    elsif post_vote.upvote == upvote
      # Delete vote
      post_vote.destroy
      upvote ? Post.find(post_id).decrement!(:vote) : Post.find(post_id).increment!(:vote)
    else
      # Change vote
      post_vote.upvote = upvote
      post_vote.save
      upvote ? Post.find(post_id).increment!(:vote, 2) : Post.find(post_id).decrement!(:vote, 2)
    end
    if params[:goto].nil?
      redirect_back fallback_location: root_path
    else
      redirect_to "#{params[:goto]}##{post_id}"
    end
  end
end
