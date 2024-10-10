require "test_helper"

class VotesControllerTest < ActionDispatch::IntegrationTest
  test "should get summary" do
    get votes_summary_url
    assert_response :success
  end
end
