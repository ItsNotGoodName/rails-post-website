require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test", password: "123456", password_confirmation: "123456").save
    @post = Post.new(title: "My Title", body: "Hello World!", user_id: @user)
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
