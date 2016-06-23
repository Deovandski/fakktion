require 'test_helper'

class Api::V1::GenresControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @testGenre = Genre.new(name: 'TEST', eligibility_counter: 0, posts_count: 0)
    @testGenre.save
    @user = User.first
    sign_in @user
  end
  # Called after test
  def teardown
    @testGenre = nil
    @apiGenre = nil
    @genreSerialized = nil
  end
  test "Genres - API - Get Index" do
    get :index
    assert_response_schema('genres/index.json')
  end
  test "Genres - API - Serializer Validation" do
    sampleSenre = Genre.new
    serializer = ActiveModel::Serializer.serializer_for(sampleSenre)
    assert_equal GenreSerializer, serializer
  end
  test "Genres - API - Create 200" do
    apiGenre = Genre.new(name: 'luka', eligibility_counter: 0, posts_count: 0)
    assert_difference('Genre.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(apiGenre).as_json
    end
  end
  test "Genres - API - Create 401" do
    sign_out @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testGenre).as_json
    assert_response(401)
  end
  test "Genres - API - Create 403" do
    @user = User.find_by_email('user@user.com')
    sign_in @user
    post :create, ActiveModelSerializers::SerializableResource.new(@testGenre).as_json
    assert_response(403)
  end
  test "Genres - API - Create 422" do
      post :create, ActiveModelSerializers::SerializableResource.new(@testGenre).as_json
      assert_response(422)
  end
  test "Genres - API - SHOW 200" do
    get :show, id: @testGenre
    assert_response_schema('genres/show.json')
  end
  test "Genres - API - UPDATE 200" do
    genre = Genre.find_by name: 'test'
    genre.name = "mikuchan"
    tempGenre = ActiveModelSerializers::SerializableResource.new(genre).serializable_hash
    post :update, tempGenre.merge(id: genre)
    genreUpdated = Genre.find_by name: 'mikuchan'
    assert_response :success, genreUpdated
  end
  test "Genres - API - UPDATE 401" do
    sign_out @user
    genre = Genre.find_by name: 'test'
    genre1 = Genre.find_by name: 'action'
    genre.name = "mikuchan"
    genre1.name = "mikuchan"
    tempGenre = ActiveModelSerializers::SerializableResource.new(genre).serializable_hash
    tempGenre1 = ActiveModelSerializers::SerializableResource.new(genre1).serializable_hash
    post :update, tempGenre.merge(id: genre)
    post :update, tempGenre1.merge(id: genre1)
    assert_response(401)
  end
  test "Genres - API - UPDATE 403" do
    @user = User.find_by_email('user@user.com')
    sign_in @user
    genre = Genre.find_by name: 'test'
    genre1 = Genre.find_by name: 'action'
    genre.name = "mikuchan"
    genre1.name = "mikuchan"
    tempGenre = ActiveModelSerializers::SerializableResource.new(genre).serializable_hash
    tempGenre1 = ActiveModelSerializers::SerializableResource.new(genre1).serializable_hash
    post :update, tempGenre.merge(id: genre)
    post :update, tempGenre1.merge(id: genre1)
    assert_response(403)
  end
  test "Genres - API - UPDATE 422" do
    genre = Genre.find_by name: 'test'
    genre1 = Genre.find_by name: 'action'
    genre.name = "mikuchan"
    genre1.name = "mikuchan"
    tempGenre = ActiveModelSerializers::SerializableResource.new(genre).serializable_hash
    tempGenre1 = ActiveModelSerializers::SerializableResource.new(genre1).serializable_hash
    post :update, tempGenre.merge(id: genre)
    post :update, tempGenre1.merge(id: genre1)
    assert_response(422)
  end
  test "Genres - API - DELETE 405" do
    genre = Genre.find_by name: 'action'
    post = Post.first
    post.genre = genre
    post.save
    delete :destroy, id: genre
    assert_response(405)
  end
end
