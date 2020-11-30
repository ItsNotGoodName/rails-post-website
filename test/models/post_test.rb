require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = Post.new(title: "My Title", body: "Hello World!", user: User.first)
  end

  test "valid post" do
    assert @post.valid?
  end

  test "post should have user" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "post should have title" do
    @post.title = nil
  end

  test "post validation should reject invalid title" do
    invalid_titles = [
      "   ",
      "ab",
      "a" * 51
    ]
    invalid_titles.each do |i|
      @post.title = i
      assert_not @post.valid?, "#{i.inspect} should be invalid"
    end
  end

  test "post validation should reject invalid body" do
    invalid_body = [
      "   ",
      "ab",
      "a" * 1001
    ]
    invalid_body.each do |i|
      @post.body = i
      assert_not @post.valid?, "#{i.inspect} should be invalid"
    end
  end
end
