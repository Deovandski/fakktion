require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @user = User.find_by_email('user@example.com')
    sign_in @user
  end
  # Called after test
  def teardown
    @testGenre = nil
    @apiGenre = nil
    @genreSerialized = nil
  end
  test "Users - API - Get Index" do
    get :index
    assert_response_schema('genres/index.json')
  end
  test "Users - API - SHOW 200" do
    get :show, id: @user
    assert_response_schema('genres/show.json')
  end
  test "Users - API - Create 200" do
    testUser = User.new( display_name: 'TESTT', full_name: 'TESTT',
      date_of_birth: DateTime.parse("20010429162748"),legal_terms_read: true, privacy_terms_read: true,
      show_full_name: true, reputation: 0, posts_count: 0, is_admin: false,
      is_super_user: false, is_legend: false, webpage_url: "", facebook_url: "",
      twitter_url: "", email: "email@fakktion.com", password: "12345678")
    assert_difference('User.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(testUser).as_json
    end
  end
  test "Users - API - Create 422" do
    testUser = User.new( display_name: '1234', full_name: '1234',
      date_of_birth: DateTime.parse("20010429162748"),legal_terms_read: true, privacy_terms_read: true,
      show_full_name: true, reputation: 0, posts_count: 0, is_admin: false,
      is_super_user: false, is_legend: false, webpage_url: "", facebook_url: "",
      twitter_url: "", email: "email@email.com", password: "12345678")
    post :create, ActiveModelSerializers::SerializableResource.new(testUser).as_json
    assert_response(422)
  end
  test "Users - API - Prevent Reputation tampering" do
    testUser = User.new( display_name: 'TESTT', full_name: 'TESTT',
      date_of_birth: DateTime.parse("20010429162748"),legal_terms_read: true, privacy_terms_read: true,
      show_full_name: true, reputation: 1000, posts_count: 0, is_admin: true,
      is_super_user: true, is_legend: true, webpage_url: "", facebook_url: "",
      twitter_url: "", email: "email@fakktion.com", password: "12345678")
    post :create, ActiveModelSerializers::SerializableResource.new(testUser).as_json
    testUser = User.find_by_email("email@fakktion.com")
    assert testUser.reputation = 0
    assert !testUser.is_admin
    assert !testUser.is_super_user
    assert !testUser.is_legend
  end
  test "Users - API - UPDATE 200" do
    user = User.find_by_email("user@example.com")
    user.email = "fakktion@fakktion.com"
    tempUser = ActiveModelSerializers::SerializableResource.new(user).serializable_hash
    post :update, tempUser.merge(id: user)
    userUpdated = User.find_by_email("email@fakktion.com")
    assert_response :success, userUpdated
  end
  test "Users - API - UPDATE 403" do
    user = User.find_by_email("user@user.com")
    user.email = "user@testing.com"
    tempUser = ActiveModelSerializers::SerializableResource.new(user).serializable_hash
    post :update, tempUser.merge(id: user)
    assert_response(403)
  end
  test "Users - API - UPDATE 422" do
    user = User.find_by_email("user@example.com")
    user.email = "user@user.com"
    tempUser = ActiveModelSerializers::SerializableResource.new(user).serializable_hash
    post :update, tempUser.merge(id: user)
    assert_response(422)
  end
  test "Users - API - DELETE 405" do
    user = User.find_by_email("user@example.com")
    delete :destroy, id: user
    assert_response(405)
  end
end
