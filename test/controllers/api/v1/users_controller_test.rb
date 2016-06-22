require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @testUser = User.new( display_name: 'TESTT', full_name: 'TESTT',
      date_of_birth: DateTime.parse("20010429162748"),legal_terms_read: true, privacy_terms_read: true,
      show_full_name: true, reputation: 1000, posts_count: 0, is_admin: true,
      is_super_user: true, is_legend: true, webpage_url: "", facebook_url: "",
      twitter_url: "", email: "email@fakktion.com", password: "12345678")
    @testUser2 = User.new( display_name: 'TESTSTE', full_name: 'DSDSDSDSD',
      date_of_birth: DateTime.parse("20010429162748"),legal_terms_read: true, privacy_terms_read: true,
      show_full_name: true, reputation: 1000, posts_count: 0, is_admin: true,
      is_super_user: true, is_legend: true, webpage_url: "", facebook_url: "",
      twitter_url: "", email: "fakktion@fakktion.com", password: "12345678")
    @testPost = Post.first
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @user = User.find_by_email('user@example.com')
    sign_in @user
  end
  # Called after test
  def teardown
    @testUser = nil
    @testUser2 = nil
    @testPost = nil
    @testGenre = nil
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
    assert_difference('User.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(@testUser).as_json
    end
  end
  test "Users - API - Create 422" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testUser).as_json
    post :create, ActiveModelSerializers::SerializableResource.new(@testUser).as_json
    assert_response(422)
  end
  test "Users - API - Prevent Reputation tampering" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testUser).as_json
    testUser = User.find_by_email("email@fakktion.com")
    assert testUser.reputation = 0
    assert_not testUser.is_admin
    assert_not testUser.is_super_user
    assert_not testUser.is_legend
  end
  test "Users - API - UPDATE NO PW - 200" do
    @user.email = "fakktion@fakktion.com"
    tempUser = ActiveModelSerializers::SerializableResource.new(@user).serializable_hash
    post :update, tempUser.merge(id: @user)
    assert_response :success
  end
  test "Users - API - UPDATE W/ PW 200" do
    @user.email = "fakktion@fakktion.com"
    @user.current_password = "12345678"
    @user.password = "123456789"
    tempUser = ActiveModelSerializers::SerializableResource.new(@user).serializable_hash
    post :update, tempUser.merge(id: @user)
    assert_response :success
  end
  test "Users - API - UPDATE W/ WRONG PW 422" do
    @user.email = "fakktion@fakktion.com"
    @user.current_password = "wrongPassword"
    @user.password = "123456789"
    tempUser = ActiveModelSerializers::SerializableResource.new(@user).serializable_hash
    post :update, tempUser.merge(id: @user)
    assert_response :unprocessable_entity
  end
  test "Users - API - UPDATE 403" do
    user = User.find_by_email("user@user.com")
    user.email = "user@testing.com"
    tempUser = ActiveModelSerializers::SerializableResource.new(@user).serializable_hash
    post :update, tempUser.merge(id: user)
    assert_response(403)
  end
  test "Users - API - UPDATE 422" do
    @user.email = "user@user.com"
    tempUser = ActiveModelSerializers::SerializableResource.new(@user).serializable_hash
    post :update, tempUser.merge(id: @user)
    assert_response(422)
  end
  test "Users - API - DELETE 405" do
    delete :destroy, id: @user
    assert_response(405)
  end
  test "Users - ACTIVE RECORD - CAN DELETE" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testUser).as_json
    user = User.find_by_email("email@fakktion.com")
    assert_difference('User.count', -1) do
      user.destroy
    end
  end
  test "Users - ACTIVE RECORD - CANNOT DELETE" do
    assert_difference('User.count', 0) do
      @user.destroy
    end
  end
end
