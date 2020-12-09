class VotesController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  include VotesHelper
  before_action :require_login
  before_action :find_voteable

  def vote
    @vote = vote_on_voteable current_user, @voteable, params[:value].to_i
    if !request.xhr?
      redirect_to "#{params[:goto]}##{voteable_anchor(@voteable)}"
    end
  end

  private

  def find_voteable
    model = [Post, Comment].detect { |c| params["#{c.name.underscore}_id"] }
    @voteable = model.find(params["#{model.name.underscore}_id"])
  end
end
