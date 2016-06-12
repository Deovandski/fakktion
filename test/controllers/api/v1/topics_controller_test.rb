require 'test_helper'

class Api::V1::TopicsControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @testTopic = Topic.new(name: 'Testing Topic', eligibility_counter: 0, posts_count: 0)
    @testTopic.save
    @user = User.first
    sign_in @user
  end
  # Called after test
  def teardown
    @testTopic = nil
    @apiTopic = nil
    @TopicSerializer = nil
  end
  test "Topics - API - Get Index" do
    get :index
    assert_response_schema('topics/index.json')
  end
  test "Topics - API - Serializer Validation" do
    sampleTopic = Topic.new
    serializer = ActiveModel::Serializer.serializer_for(sampleTopic)
    assert_equal TopicSerializer, serializer
  end
  test "Topics - API - Create 200" do
    apiTopic = Topic.new(name: 'testng123', eligibility_counter: 0, posts_count: 0)
    assert_difference('Topic.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(apiTopic).as_json
    end
  end
  test "Topics - API - Create 422" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testTopic).as_json
    assert_response(422)
  end
  test "Topics - API - SHOW 200" do
    get :show, id: @testTopic
    assert_response_schema('topics/show.json')
  end
  test "Topics - API - UPDATE 200" do
    topic = Topic.find_by name: 'testing topic'
    topic.name = "mikuchan"
    tempTopic = ActiveModelSerializers::SerializableResource.new(topic).serializable_hash
    post :update, tempTopic.merge(id: topic)
    topicUpdated = Topic.find_by name: 'mikuchan'
    assert_response :success, topicUpdated
  end
  test "Topics - API - UPDATE 422" do
    topic = Topic.find_by name: 'hatsune miku'
    topic1 = Topic.find_by name: 'megurine luka'
    topic.name = "mikuchan"
    topic1.name = "mikuchan"
    tempTopic = ActiveModelSerializers::SerializableResource.new(topic).serializable_hash
    tempTopic1 = ActiveModelSerializers::SerializableResource.new(topic1).serializable_hash
    post :update, tempTopic.merge(id: topic)
    post :update, tempTopic1.merge(id: topic1)
    assert_response(422)
  end
  test "Topics - API - DELETE 200" do
    assert_difference('Topic.count', 0) do
      delete :destroy, id: @testTopic
    end
  end
  test "Topics - API - DELETE 405" do
    topic = Topic.find_by name: 'hatsune miku'
    post = Post.first
    post.topic = topic
    post.save
    delete :destroy, id: topic
    assert_response(405)
  end
end
