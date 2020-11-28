module VotesHelper
  VALID_VOTES = [-1, 1].freeze

  def vote_on_voteable(user, voteable, new_value)
    return unless VotesHelper::VALID_VOTES.include? new_value

    target_vote = voteable.votes.find_or_create_by(user_id: user.id)

    if target_vote.value.nil?
      # New voter
      target_vote.value = new_value
      target_vote.save
      voteable.increment!(:vote, new_value)
    elsif target_vote.value == new_value
      # Delete vote
      target_vote.destroy
      voteable.increment!(:vote, -new_value)
    else
      # Change vote
      target_vote.value = new_value
      target_vote.save
      voteable.increment!(:vote, 2 * new_value)
    end
  end
end
