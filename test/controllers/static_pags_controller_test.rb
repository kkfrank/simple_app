require 'test_helper'

class StaticPagsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pags_home_url
    assert_response :success
  end

  test "should get help" do
    get static_pags_help_url
    assert_response :success
  end

end
