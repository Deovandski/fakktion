require 'test_helper'

class Api::V1::AdminMessagesControllerTest < ActionController::TestCase
# Waiting for Genres Test Controller to be finished
  test "API - should get index" do
    get :index
    assert_response_schema('adminMessages/index.json')
  end
end
