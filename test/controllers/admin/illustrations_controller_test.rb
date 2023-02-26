require "test_helper"

class Admin::IllustrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_illustrations_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_illustrations_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_illustrations_edit_url
    assert_response :success
  end
end
