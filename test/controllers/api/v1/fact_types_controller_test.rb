require 'test_helper'

class Api::V1::FactTypesControllerTest < ActionController::TestCase
# Waiting for Genres Test Controller to be finished
  test "API - should get index" do
    get :index
    assert_response_schema('factTypes/index.json')
  end
end
