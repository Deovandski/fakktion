require 'test_helper'

class Api::V1::CategoriesControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @testCategory = Category.new(name: 'TEST', posts_count: 0)
    @testCategory.save
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
      post :create, ActiveModel::SerializableResource.new(categoryGenre).as_json
    end
  end
  test "Categories - API - Create 422" do
      post :create, ActiveModel::SerializableResource.new(@testCategory).as_json
      assert_response(422)
  end
  test "Categories - API - SHOW 200" do
    get :show, id: @testCategory
    assert_response_schema('categories/show.json')
  end
  test "Categories - API - UPDATE 200" do
    category = Category.find_by name: 'test'
    category.name = "mikuchan"
    tempCategory = ActiveModel::SerializableResource.new(category).serializable_hash
    post :update, tempCategory.merge(id: category)
    genreUpdated = Category.find_by name: 'mikuchan'
    assert_response :success, genreUpdated
  end
  test "Categories - API - UPDATE 422" do
    category = Category.find_by name: 'test'
    category1 = Category.find_by name: 'a-b-c'
    category.name = "mikuchan"
    category1.name = "mikuchan"
    tempCategory = ActiveModel::SerializableResource.new(category).serializable_hash
    tempCategory1 = ActiveModel::SerializableResource.new(category1).serializable_hash
    post :update, tempCategory.merge(id: category)
    post :update, tempCategory1.merge(id: category1)
    assert_response(422)
  end
  test "Categories - API - DELETE 200" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @testCategory
    end
  end
  test "Categories - API - DELETE 422" do
    category = Category.find_by name: 'a-b-c'
    post = Post.first
    post.category = category
    post.save
    delete :destroy, id: category
    assert_response(422)
  end
end
