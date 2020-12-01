require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get login_path
    assert_response :success
    assert_select "title", "Login"
  end

  test "should login successfully with capitals in username" do
    post sessions_path, params: {session: {username: "Test uSer", password: 123456}}
    assert_response :redirect
    assert session[:user_id]
  end
end
