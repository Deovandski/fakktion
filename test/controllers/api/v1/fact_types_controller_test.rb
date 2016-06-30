require 'test_helper'

class Api::V1::FactTypesControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @testFactType = FactType.new(name: 'TEST', eligibility_counter: 0, posts_count: 0)
    @testFactType.save
    @user = User.first
    sign_in @user    
  end
  # Called after test
  def teardown
    @testFactType = nil
    @apiFactType = nil
    @factTypeSerialized = nil
  end
  test "FactTypes - API - Get Index" do
    get :index
    assert_response_schema('factTypes/index.json')
  end
  test "FactTypes - API - Serializer Validation" do
    sampleFactType = FactType.new
    serializer = ActiveModel::Serializer.serializer_for(sampleFactType)
    assert_equal FactTypeSerializer, serializer
  end
  test "FactTypes - API - Create 200" do
    apiFactType = FactType.new(name: 'luka', eligibility_counter: 0, posts_count: 0)
    assert_difference('FactType.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(apiFactType).as_json
    end
  end
  test "FactTypes - API - Create 401" do
    sign_out @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testFactType).as_json
    assert_response(401)
  end
  test "FactTypes - API - Create 403" do
    @user = User.find_by_email('user@user.com')
    sign_in @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testFactType).as_json
    assert_response(403)
  end
  test "FactTypes - API - Create 422" do
    post :create, ActiveModelSerializers::SerializableResource.new(@testFactType).as_json
    assert_response(422)
  end
  test "FactTypes - API - SHOW 200" do
    get :show, id: @testFactType
    assert_response_schema('factTypes/show.json')
  end
  test "FactTypes - API - UPDATE 200" do
    factType = FactType.find_by name: 'test'
    factType.name = "mikuchan"
    tempFactType = ActiveModelSerializers::SerializableResource.new(factType).serializable_hash
    post :update, tempFactType.merge(id: factType)
    factTypeUpdated = FactType.find_by name: 'mikuchan'
    assert_response :success, factTypeUpdated
  end
  test "FactTypes - API - UPDATE 401" do
    sign_out @user
    factType = FactType.find_by name: 'test'
    factType1 = FactType.find_by name: 'technology'
    factType.name = "mikuchan"
    factType1.name = "mikuchan"
    tempFactType = ActiveModelSerializers::SerializableResource.new(factType).serializable_hash
    tempFactType1 = ActiveModelSerializers::SerializableResource.new(factType1).serializable_hash
    post :update, tempFactType.merge(id: factType)
    post :update, tempFactType1.merge(id: factType1)
    assert_response(401)
  end
  test "FactTypes - API - UPDATE 403" do
    @user = User.find_by_email('user@user.com')
    sign_in @user
    factType = FactType.find_by name: 'test'
    factType1 = FactType.find_by name: 'technology'
    factType.name = "mikuchan"
    factType1.name = "mikuchan"
    tempFactType = ActiveModelSerializers::SerializableResource.new(factType).serializable_hash
    tempFactType1 = ActiveModelSerializers::SerializableResource.new(factType1).serializable_hash
    post :update, tempFactType.merge(id: factType)
    post :update, tempFactType1.merge(id: factType1)
    assert_response(403)
  end
  test "FactTypes - API - UPDATE 422" do
    factType = FactType.find_by name: 'test'
    factType1 = FactType.find_by name: 'technology'
    factType.name = "mikuchan"
    factType1.name = "mikuchan"
    tempFactType = ActiveModelSerializers::SerializableResource.new(factType).serializable_hash
    tempFactType1 = ActiveModelSerializers::SerializableResource.new(factType1).serializable_hash
    post :update, tempFactType.merge(id: factType)
    post :update, tempFactType1.merge(id: factType1)
    assert_response(422)
  end
  test "FactTypes - API - DELETE 200" do
    assert_difference('FactType.count', 0) do
      delete :destroy, id: @testFactType
    end
  end
  test "FactTypes - API - DELETE 405" do
    factType = FactType.find_by name: 'technology'
    post = Post.first
    post.fact_type = factType
    post.save
    delete :destroy, id: factType
    assert_response(405)
  end
  test "FactTypes - ACTIVE RECORD - CAN DELETE" do
    assert_difference('FactType.count', -1) do
      @testFactType.destroy
    end
  end
  test "FactTypes - ACTIVE RECORD - CANNOT DELETE" do
    genre = Genre.first
    topic = Topic.first
    factType = FactType.first
    category = Category.first
    topic = Topic.first
    testPost = Post.new(user_id: @user.id, genre_id: genre.id, category_id: category.id, fact_type_id: factType.id, topic_id: topic.id,
    views_count: 0,
    comments_count: 0,
    fact_link: "https://www.google.com",
    fiction_link: "https://www.google.com",
    title: "THis is a testing title for the sake of testing the title",
    text: "test text for testing text so that I can test out the backend text............................................................")
    testPost.save
    assert_difference('FactType.count', 0) do
      factType.destroy
    end
  end
end
