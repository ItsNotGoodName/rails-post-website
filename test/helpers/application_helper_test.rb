require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "Post Website", full_title
    assert_equal "This is a Title", full_title("This is a Title")
  end
end
