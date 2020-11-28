require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get login_path
    assert_response :success
    assert_select "title", "Login"
  end
end
