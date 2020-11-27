class PostVotesController < ApplicationController
  include SessionHelper
  include PostVotesHelper
  before_action :require_login

  def vote
    post = Post.find(params[:post_id])
    upvote = params[:upvote].to_i == 1
    vote_on_post current_user, post, upvote

    if params[:goto].nil?
      redirect_back fallback_location: root_path
    else
      redirect_to "#{params[:goto]}##{post.id}"
    end
  end
end
