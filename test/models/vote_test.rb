require "test_helper"

class VoteTest < ActiveSupport::TestCase
  def setup
    @vote = Post.first.votes.create(value: -1, user: User.first)
  end

  test "should be valid" do
    assert @vote.valid?
  end

  test "vote's value should not be 0" do
    @vote.value = 0
    assert_not @vote.valid?
  end

  test "vote should have value" do
    @vote.value = nil
    assert_not @vote.valid?
  end

  test "vote should have user" do
    @vote.user = nil
    assert_not @vote.valid?
  end
end
