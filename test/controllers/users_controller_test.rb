require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get register_path
    assert_response :success
    assert_select "title", "Register"
  end

  test "should create user and login" do
    post register_path, params: {user: {username: "test", password: "123456", password_confirmation: "123456"}}
    assert_response :success
    assert [:user_id]
  end
end
