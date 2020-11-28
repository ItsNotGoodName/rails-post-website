module VotesHelper
  VALID_VOTES = [-1, 1]

  def vote_on_target(user, target, new_value)
    return unless VotesHelper::VALID_VOTES.include? new_value

    target_vote = target.votes.find_by(user_id: user.id)

    if target_vote.value.nil?
      # New voter
      target_vote.value = new_value
      target_vote.save
      target.increment!(:vote, new_value)
    elsif target_vote.value == new_value
      # Delete vote
      target_vote.destroy
      target.increment!(:vote, -new_value)
    else
      # Change vote
      target_vote.value = new_value
      target_vote.save
      target.increment!(:vote, 2 * new_value)
    end
  end
end
