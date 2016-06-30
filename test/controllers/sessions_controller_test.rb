require 'test_helper'
# Devise Session Testing.
class SessionsControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @user = User.find_by_email('user@example.com')
  end
  # Called after every test
  def teardown
  end
  test "API - Devise Correct Login Initial redirect" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :create, :user => { :email => @user.email, :password => '12345678'}
    assert_response(302)
  end
  test "API - Devise Incorrect Login" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :create, :user => { :email => @user.email, :password => 'wrongPW'}
    assert_response(200)
  end
  test "API - Can Destroy Session" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :destroy, :user => { :id => @user.id, :email => @user.email, :authentication_token => @user.authentication_token}
    assert_response(302)
  end
end
