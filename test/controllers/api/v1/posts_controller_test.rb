require 'test_helper'

class Api::V1::PostsControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @topic = Topic.first
    @factType = FactType.first
    @category = Category.first
    @user = User.first
    @topic = Topic.first
    @testPost = Post.new(user_id: @user.id,  category_id: @category.id, fact_type_id: @factType.id, topic_id: @topic.id,
    views_count: 0,
    comments_count: 0,
    fact_link: "https://www.google.com",
    fiction_link: "https://www.google.com",
    title: "THis is a testing title for the sake of testing the title",
    text: "test text for testing text so that I can test out the backend text............................................................")
    @testPost.save
    @testPost_unsaved = Post.new(user_id: @user.id, category_id: @category.id, fact_type_id: @factType.id, topic_id: @topic.id,
    views_count: 0,
    comments_count: 0,
    fact_link: "https://www.google.com",
    fiction_link: "https://www.google.com",
    title: "This is a testing title for the sake of testing the title #2",
    text: "test text for testing text so that I can test out the backend text............................................................")
    sign_in @user
  end
  # Called after every test
  def teardown
    @topic = nil
    @factType = nil
    @category = nil
  end
  test "Posts - API - should get index" do
    get :index
    assert_response_schema('posts/index.json')
  end
  test "Posts - API - Create 200" do
    assert_difference('Post.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(@testPost_unsaved).as_json
    end
  end
  test "Posts - API - Create 401" do
    sign_out @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testPost_unsaved).as_json
    assert_response(401)
  end
  test "Posts - API - Create 403" do
    @user = User.find_by_email('user@user.com')
    @user.reputation = -1500
    @user.save
    sign_in @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testPost_unsaved).as_json
    assert_response(403)
  end
  test "Posts - API - Create 422" do
    @testPost_unsaved.text = ""
    post :create, ActiveModelSerializers::SerializableResource.new(@testPost_unsaved).as_json
    assert_response(422)
  end
  test "Posts - API - XSS PROTECTION" do
    @testPost = Post.first
    @testPost.text = "<h1>NOPE</h1><p><b>MKAY TEXT</b>ALLOWED TO STAY</p><h1>NOPE</h1><p><b>MKAY TEXT</b>ALLOWED TO STAY</p><h1>NOPE</h1><p><b>MKAY TEXT</b>ALLOWED TO STAY</p>"
    tempPost = ActiveModelSerializers::SerializableResource.new(@testPost).serializable_hash
    post :update, tempPost.merge(id: @testPost)
    @testPost = Post.first
    assert_equal(@testPost.text, 'NOPE<p><b>MKAY TEXT</b>ALLOWED TO STAY</p>NOPE<p><b>MKAY TEXT</b>ALLOWED TO STAY</p>NOPE<p><b>MKAY TEXT</b>ALLOWED TO STAY</p>')
  end
  test "Posts - API - SHOW 200" do
    @testPost = Post.first
    get :show, id: @testPost
    assert_response_schema('posts/show.json')
  end
  test "Posts - API - UPDATE 200" do
    @testPost = Post.first
    tempPost = ActiveModelSerializers::SerializableResource.new(@testPost).serializable_hash
    post :update, tempPost.merge(id: @testPost)
    assert_response :success
  end
  test "Posts - API - UPDATE 200 - Increase views_count" do
    @testPost = Post.first
    sign_out @user
    @testPost.increment(:views_count)
    @testPost.text = "..........................................................."
    tempPost = ActiveModelSerializers::SerializableResource.new(@testPost).serializable_hash
    post :update, tempPost.merge(id: @testPost)
    assert_response(200)
  end
  test "Posts - API - UPDATE 401" do
    @testPost = Post.first
    sign_out @user
    @testPost.text = "..........................................................."
    tempPost = ActiveModelSerializers::SerializableResource.new(@testPost).serializable_hash
    post :update, tempPost.merge(id: @testPost)
    assert_response(401)
  end
  test "Posts - API - INCREASE VIEW_COUNTER" do
    @user = User.find_by_email('user@user.com')
    @user.reputation = 0
    @user.save
    sign_in @user
    @testPost = Post.first
    @testPost.text = "..........................................................."
    tempPost = ActiveModelSerializers::SerializableResource.new(@testPost).serializable_hash
    sign_out @user
    @user = User.find_by_email('user@user.com')
    @user.reputation = -3500
    @user.save
    sign_in @user
    post :update, tempPost.merge(id: @testPost)
    assert_response(200)
  end
  test "Posts - API - UPDATE 422" do
    @testPost = Post.first
    @testPost.text = ""
    tempPost = ActiveModelSerializers::SerializableResource.new(@testPost).serializable_hash
    post :update, tempPost.merge(id: @testPost)
    assert_response(422)
  end
  test "Posts - API - DELETE 405" do
    @testPost = Post.first
    delete :destroy, id: @testPost.id
    assert_response(405)
  end
end
