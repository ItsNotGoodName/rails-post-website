require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = Post.first.comments.create(body: "Hello World!", user: User.first)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "vote should be 0" do
    assert_equal @comment.vote, 0
  end

  test "body should be present" do
    @comment.body = nil
    assert_not @comment.valid?
  end
end
