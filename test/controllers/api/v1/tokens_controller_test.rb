require 'test_helper'

class Api::V1::TokensControllerTest < ActionController::TestCase
  setup do
    @request.headers['Content-Type'] = 'application/json'
    @existingUser = User.find_by email: 'user@example.com'
  end
  test "API - Assert Response Schema" do
    post :create, {"data":{"id":@existingUser.id,"attributes":{"email":@existingUser.email,"authenticity_token":@existingUser.authentication_token},"type":"tokens"}}
    assert_response_schema('tokens/create.json')
  end
  test "API - Assert Invalid Response for Token" do
    post :create, {"data":{"id":@existingUser.id,"attributes":{"email":@existingUser.email,"authenticity_token":"invalidToken"},"type":"tokens"}}
    assert_equal(@response.body, "{\"error\":\"token and id validation failed\"}")
  end
  test "API - Assert Invalid Response for Email" do
    post :create, {"data":{"id":@existingUser.id,"attributes":{"email":"invalidEmail","authenticity_token":@existingUser.authentication_token},"type":"tokens"}}
    assert_equal(@response.body, "{\"error\":\"email and id validation failed\"}")
  end
  test "API - Assert Invalid Response for id" do
    wrongNumber = @existingUser.id + 1
    post :create, {"data":{"id":wrongNumber,"attributes":{"email":@existingUser.email,"authenticity_token":@existingUser.authentication_token},"type":"tokens"}}
    assert_equal(@response.body, "{\"error\":\"token and id validation failed\"}")
  end
  test "API - Valid Token" do
    post :create, {"data":{"id":@existingUser.id,"attributes":{"email":@existingUser.email,"authenticity_token":@existingUser.authentication_token},"type":"tokens"}}
    assert_response(200)
  end
  test "API - Invalid Token Assert (token)" do
    post :create, {"data":{"id":@existingUser.id,"attributes":{"email":@existingUser.email,"authenticity_token":"invalidToken"},"type":"tokens"}}
    assert_response(404)
  end
  test "API - Invalid Token Assert (email)" do
    post :create, {"data":{"id":@existingUser.id,"attributes":{"email":"invalidEmail","authenticity_token":@existingUser.authentication_token},"type":"tokens"}}
    assert_response(404)
  end
  test "API - Invalid Token Assert (id)" do
    wrongNumber = @existingUser.id + 1
    post :create, {"data":{"id":wrongNumber,"attributes":{"email":@existingUser.email,"authenticity_token":@existingUser.authentication_token},"type":"tokens"}}
    assert_response(404)
  end
end
