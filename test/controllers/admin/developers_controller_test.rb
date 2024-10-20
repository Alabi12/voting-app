require "test_helper"

class Admin::DevelopersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_developers_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_developers_create_url
    assert_response :success
  end
end
