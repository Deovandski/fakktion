require 'test_helper'

class Api::V1::GenresControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @testGenre = Genre.new(name: 'TEST', eligibility_counter: 0, posts_count: 0)
    @testGenre.save
    @apiGenre = Genre.new(name: 'luka', eligibility_counter: 0, posts_count: 0)
  end
  # Called after test
  def teardown
    @testGenre = nil
    @apiGenre = nil
    @genreSerialized = nil
  end
  test "API - should get index" do
    get :index
    assert_response_schema('genres/index.json')
  end
  test "API - Test Genre Serializer" do
    sampleSenre = Genre.new
    serializer = ActiveModel::Serializer.serializer_for(sampleSenre)
    assert_equal GenreSerializer, serializer
  end
  test "API - Create a Genre" do
    assert_difference('Genre.count', +1) do
      post :create, ActiveModel::SerializableResource.new(@apiGenre).as_json
    end
  end
  test "API - Trigger Unprocessable Entity (422) when attempting to creating a genre that already exists." do
      post :create, ActiveModel::SerializableResource.new(@testGenre).as_json
      assert_response(422)
  end
  test "API - Get a genre" do
    get :show, id: @testGenre.id
    assert_response_schema('genres/show.json')
  end
  test "API - Check that all saved Genres are lowercase normalized" do
    # TODO
  end
  test "API - Update a genre" do
    genre = Genre.find_by name: 'test'
    genre.name = "mikuchan"
    #post :update, id: genre.id, ActiveModel::SerializableResource.new(genre).as_json
    genreUpdated = Genre.find_by name: 'mikuchan'
    assert_response :success, genreUpdated
  end
  test "API - Trigger Unprocessable Entity (422) when attempting to update a genre to a name that already exists" do
      # TODO
  end
  test "API - Destroy a Genre" do
    assert_difference('Genre.count', -1) do
      delete :destroy, id: @testGenre.id
    end
  end
end
