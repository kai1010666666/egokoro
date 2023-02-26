require "test_helper"

class User::IllustrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_illustrations_index_url
    assert_response :success
  end

  test "should get show" do
    get user_illustrations_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_illustrations_edit_url
    assert_response :success
  end
end
