class VotesController < ApplicationController
  include SessionHelper
  include VotesHelper
  before_action :require_login

  def vote
    post = Post.find(params[:post_id])
    value = params[:value].to_i
    vote_on_target current_user, post, value

    if params[:goto].nil?
      redirect_back fallback_location: root_path
    else
      redirect_to "#{params[:goto]}##{post.id}"
    end
  end
end
