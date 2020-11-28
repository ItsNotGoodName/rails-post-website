class VotesController < ApplicationController
  include SessionHelper
  include VotesHelper
  before_action :require_login
  before_action :find_parent

  def vote
    value = params[:value].to_i
    vote_on_target current_user, @parent, value

    if params[:goto].nil?
      redirect_back fallback_location: root_path
    else
      redirect_to "#{params[:goto]}##{@parent.id}"
    end
  end

  private

  def find_parent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @parent = $1.classify.constantize.find(value)
      end
    end
  end
end
