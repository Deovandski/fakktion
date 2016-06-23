require 'test_helper'

class Api::V1::CategoriesControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @testCategory = Category.new(name: 'TEST', posts_count: 0)
    @testCategory.save
    @user = User.first
    sign_in @user
  end
  # Called after test
  def teardown
    @testCategory = nil
    @categoryGenre = nil
    @genreSerialized = nil
  end
  test "Categories - API - Get Index" do
    get :index
    assert_response_schema('categories/index.json')
  end
  test "Categories - API - Serializer Validation" do
    sampleCategory = Category.new
    serializer = ActiveModel::Serializer.serializer_for(sampleCategory)
    assert_equal CategorySerializer, serializer
  end
  test "Categories - API - Create 200" do
    categoryGenre = Category.new(name: 'luka', posts_count: 0)
    assert_difference('Category.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(categoryGenre).as_json
    end
  end
  test "Categories - API - Create 401" do
      sign_out @user
      post :create, ActiveModelSerializers::SerializableResource.new(@testCategory).as_json
      assert_response(401)
  end
  test "Categories - API - Create 403" do
      @user = User.find_by_email('user@user.com')
      sign_in @user
      post :create, ActiveModelSerializers::SerializableResource.new(@testCategory).as_json
      assert_response(403)
  end
  test "Categories - API - Create 422" do
      post :create, ActiveModelSerializers::SerializableResource.new(@testCategory).as_json
      assert_response(422)
  end
  test "Categories - API - SHOW 200" do
    get :show, id: @testCategory
    assert_response_schema('categories/show.json')
  end
  test "Categories - API - UPDATE 200" do
    category = Category.find_by name: 'test'
    category.name = "mikuchan"
    tempCategory = ActiveModelSerializers::SerializableResource.new(category).serializable_hash
    post :update, tempCategory.merge(id: category)
    categoryUpdated = Category.find_by name: 'mikuchan'
    assert_response :success, categoryUpdated
  end
  test "Categories - API - UPDATE 401" do
    sign_out @user
    category = Category.find_by name: 'test'
    category1 = Category.find_by name: 'movie'
    category.name = "mikuchan"
    category1.name = "mikuchan"
    tempCategory = ActiveModelSerializers::SerializableResource.new(category).serializable_hash
    tempCategory1 = ActiveModelSerializers::SerializableResource.new(category1).serializable_hash
    post :update, tempCategory.merge(id: category)
    post :update, tempCategory1.merge(id: category1)
    assert_response(401)
  end
  test "Categories - API - UPDATE 403" do
    @user = User.find_by_email('user@user.com')
    sign_in @user
    category = Category.find_by name: 'test'
    category1 = Category.find_by name: 'movie'
    category.name = "mikuchan"
    category1.name = "mikuchan"
    tempCategory = ActiveModelSerializers::SerializableResource.new(category).serializable_hash
    tempCategory1 = ActiveModelSerializers::SerializableResource.new(category1).serializable_hash
    post :update, tempCategory.merge(id: category)
    post :update, tempCategory1.merge(id: category1)
    assert_response(403)
  end
  test "Categories - API - UPDATE 422" do
    category = Category.find_by name: 'test'
    category1 = Category.find_by name: 'movie'
    category.name = "mikuchan"
    category1.name = "mikuchan"
    tempCategory = ActiveModelSerializers::SerializableResource.new(category).serializable_hash
    tempCategory1 = ActiveModelSerializers::SerializableResource.new(category1).serializable_hash
    post :update, tempCategory.merge(id: category)
    post :update, tempCategory1.merge(id: category1)
    assert_response(422)
  end
  test "Categories - API - DELETE 200" do
    assert_difference('Category.count', 0) do
      delete :destroy, id: @testCategory
    end
  end
  test "Categories - API - DELETE 405" do
    category = Category.find_by name: 'movie'
    post = Post.first
    post.category = category
    post.save
    delete :destroy, id: category
    assert_response(405)
  end
end
