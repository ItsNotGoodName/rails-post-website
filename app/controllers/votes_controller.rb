class VotesController < ApplicationController
  include SessionHelper
  include VotesHelper
  before_action :require_login
  before_action :find_votable

  def vote
    value = params[:value].to_i
    vote_on_votable current_user, @voteable, value

    if params[:goto].nil?
      redirect_back fallback_location: root_path
    else
      redirect_to "#{params[:goto]}##{@voteable.id}"
    end
  end

  private

  def find_votable
    model = [Post].detect { |c| params["#{c.name.underscore}_id"] }
    @voteable = model.find(params["#{model.name.underscore}_id"])
  end
end
