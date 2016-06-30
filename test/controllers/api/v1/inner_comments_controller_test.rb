require 'test_helper'

class Api::V1::InnerCommentsControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @user = User.first
    @post = Post.first
    @testComment = Comment.new(user_id: @user.id, post_id: @post.id, empathy_level: 0, inner_comments_count: 0, text: "Hello hello, (hola!) I'm at a place called Vertigo (Donde estás?)")
    @testComment.save
    @testInnerComment = InnerComment.new(user_id: @user.id, comment_id: @testComment.id, empathy_level: 0, text: 'testing text for the minimun amount of text!!!!!!')
    sign_in @user
  end
  # Called after every test
  def teardown
    @user = nil
    @post = nil
    @testComment = nil
    @testInnerComment = nil
  end
  test "InnerComments - API - should get index" do
    get :index
    assert_response_schema('innerComments/index.json')
  end
  test "InnerComments - API - Create 200" do
    assert_difference('InnerComment.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    end
  end
  test "InnerComments - API - Create 401" do
    sign_out @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    assert_response(401)
  end
  test "InnerComments - API - Create 403" do
    @user = User.find_by_email('user@user.com')
    sign_in @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    assert_response(403)
  end
  test "InnerComments - API - Create 422" do
    @testInnerComment.text = "..."
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    assert_response(422)
  end
  test "InnerComments - API - SHOW 200" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    @testInnerComment = InnerComment.first
    get :show, id: @testInnerComment
    assert_response_schema('innerComments/show.json')
  end
  test "InnerComments - API - UPDATE 200" do
    @testInnerComment.text = "..........................................................."
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    @testInnerComment = InnerComment.first
    tempInnerComment = ActiveModelSerializers::SerializableResource.new(@testInnerComment).serializable_hash
    post :update, tempInnerComment.merge(id: @testInnerComment)
    assert_response :success
  end
  test "InnerComments - API - UPDATE 401" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    @testInnerComment = InnerComment.first
    sign_out @user
    @testComment.text = "..........................................................."
    tempInnerComment = ActiveModelSerializers::SerializableResource.new(@testInnerComment).serializable_hash
    post :update, tempInnerComment.merge(id: @testInnerComment)
    assert_response(401)
  end
  test "InnerComments - API - UPDATE 403" do
    @user = User.find_by_email('user@user.com')
    @user.reputation = 0
    @user.save
    sign_in @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    @testInnerComment = InnerComment.first
    @testInnerComment.text = "..........................................................."
    tempInnerComment = ActiveModelSerializers::SerializableResource.new(@testInnerComment).serializable_hash
    sign_out @user
    @user = User.find_by_email('user@user.com')
    @user.reputation = -3500
    @user.save
    sign_in @user
    post :update, tempInnerComment.merge(id: @testInnerComment)
    assert_response(403)
  end
  test "InnerComments - API - UPDATE 422" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    @testInnerComment = InnerComment.first
    @testInnerComment.text = ".."
    tempInnerComment = ActiveModelSerializers::SerializableResource.new(@testInnerComment).serializable_hash
    post :update, tempInnerComment.merge(id: @testInnerComment)
    assert_response(422)
  end
  test "InnerComments - API - DELETE 405" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testInnerComment).as_json
    @testInnerComment = InnerComment.first
    delete :destroy, id: @testComment.id
    assert_response(405)
  end
end
