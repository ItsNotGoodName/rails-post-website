module VoteHelper
  def vote_on_target(user, target, new_value)
    target_vote = Vote.find_by(user_id: user.id, voteable_id: target.id)

    if target_vote.nil?
      # New voter
      Vote.new(user_id: user.id, voteable_id: target.id, value: new_value).save
      target.increment!(:vote, new_value ? 1 : -1)
    elsif target_vote.value == new_value
      # Delete vote
      target_vote.destroy
      target.increment!(:vote, new_value ? -1 : 1)
    else
      # Change vote
      target_vote.upvote = new_value
      target_vote.save
      target.increment!(:vote, new_value ? 2 : -2)
    end
  end
end
