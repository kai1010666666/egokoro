require "test_helper"

class Admin::AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_accounts_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_accounts_edit_url
    assert_response :success
  end
end
