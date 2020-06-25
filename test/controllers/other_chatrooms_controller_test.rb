require 'test_helper'

class OtherChatroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get other_chatrooms_index_url
    assert_response :success
  end

end
