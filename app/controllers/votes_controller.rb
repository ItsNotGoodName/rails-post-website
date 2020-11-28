class VotesController < ApplicationController
  include ApplicationHelper
  include SessionHelper
  include VotesHelper
  before_action :require_login
  before_action :find_voteable

  def vote
    value = params[:value].to_i
    vote_on_votable current_user, @voteable, value

    goto_or_goback(@voteable.id)
  end

  private

  def find_voteable
    model = [Post, Comment].detect { |c| params["#{c.name.underscore}_id"] }
    @voteable = model.find(params["#{model.name.underscore}_id"])
  end
end
