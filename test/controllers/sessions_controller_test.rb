require 'test_helper'
# Devise Session Testing.
class SessionsControllerTest < ActionController::TestCase
  test "API - Devise Correct Login Initial redirect" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :create, :user => { :email => 'user@example.com', :password => '12345678'}
    assert_response(302)
  end
  test "API - Devise Incorrect Login" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :create, :user => { :email => 'user@example.com', :password => 'wrongPW'}
    assert_response(200)
  end
end
