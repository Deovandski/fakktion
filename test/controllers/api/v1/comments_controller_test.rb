require 'test_helper'

class Api::V1::CommentsControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @post = Post.first
    @user = User.first
    @testComment = Comment.new(user_id: @user.id, post_id: @post.id, empathy_level: 0, text: 'testing text for the minimun amount of text!!!!!!')
    sign_in @user
  end
  # Called after every test
  def teardown
    @user = nil
    @post = nil
  end
  test "Comments - API - should get index" do
    get :index
    assert_response_schema('comments/index.json')
  end
  test "Comments - API - Create 200" do
    assert_difference('Comment.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    end
  end
  test "Comments - API - Create 401" do
    sign_out @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    assert_response(401)
  end
  test "Comments - API - Create 403" do
    @user = User.find_by_email('user@user.com')
    @user.reputation = -1500
    @user.save
    sign_in @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    assert_response(403)
  end
  test "Comments - API - Create 422" do
    @testComment.text = ""
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    assert_response(422)
  end
  test "Comments - API - XSS PROTECTION" do
    @testComment.text = "<h1>NOPE</h1><p><b>MKAY TEXT</b>ALLOWED TO STAY</p>"
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    @testComment = Comment.first
    assert_equal(@testComment.text, 'NOPE<p><b>MKAY TEXT</b>ALLOWED TO STAY</p>')
  end
  test "Comments - API - SHOW 200" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    @testComment = Comment.first
    get :show, id: @testComment
    assert_response_schema('comments/show.json')
  end
  test "Comments - API - UPDATE 200" do
    @testComment.text = "..........................................................."
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    @testComment = Comment.first
    tempComment = ActiveModelSerializers::SerializableResource.new(@testComment).serializable_hash
    post :update, tempComment.merge(id: @testComment)
    assert_response :success
  end
  test "Comments - API - UPDATE 401" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    @testComment = Comment.first
    sign_out @user
    @testComment.text = "..........................................................."
    tempComment = ActiveModelSerializers::SerializableResource.new(@testComment).serializable_hash
    post :update, tempComment.merge(id: @testComment)
    assert_response(401)
  end
  test "Comments - API - UPDATE 403" do
    @user = User.find_by_email('user@user.com')
    @user.reputation = 0
    @user.save
    sign_in @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    @testComment = Comment.first
    @testComment.text = "..........................................................."
    tempComment = ActiveModelSerializers::SerializableResource.new(@testComment).serializable_hash
    sign_out @user
    @user = User.find_by_email('user@user.com')
    @user.reputation = -3500
    @user.save
    sign_in @user
    post :update, tempComment.merge(id: @testComment)
    assert_response(403)
  end
  test "Comments - API - UPDATE 422" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    @testComment = Comment.first
    @testComment.text = ""
    tempComment = ActiveModelSerializers::SerializableResource.new(@testComment).serializable_hash
    post :update, tempComment.merge(id: @testComment)
    assert_response(422)
  end
  test "Comments - API - DELETE 405" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testComment).as_json
    @testComment = Comment.first
    delete :destroy, id: @testComment.id
    assert_response(405)
  end
end
