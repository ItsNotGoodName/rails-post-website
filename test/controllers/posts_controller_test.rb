require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_post_path
    assert_response :success
  end

  test 'should get index' do
    get posts_path
    assert_response :success
  end
end
