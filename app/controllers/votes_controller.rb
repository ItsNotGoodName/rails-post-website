class VotesController < ApplicationController
  include ApplicationHelper
  include SessionHelper
  include VotesHelper
  before_action :require_login
  before_action :find_voteable

  def vote
    vote_on_voteable current_user, @voteable, params[:value].to_i
    goto_or_goback(@voteable.id, @voteable_prefix)
  end

  private

  def find_voteable
    model = [Post, Comment].detect { |c| params["#{c.name.underscore}_id"] }
    @voteable = model.find(params["#{model.name.underscore}_id"])
    @voteable_prefix = model.name.underscore.first
  end
end
