require 'test_helper'

class Api::V1::GenresControllerTest < ActionController::TestCase
  test "should get index" do
    genres = get :index
    assert_response :success, genres
  end
  test "Check that all saved Genres are lowercase normalized" do
    genre = Genre.new(name: 'TEST', eligibility_counter: 0, posts_count: 0)
    genre.save
    genre = Genre.find_by name: 'TEST'
    assert_response :success, genre
  end
  test "Get a genre" do
    assert_response :success, Genre.first()
  end
  test "Save a Genre" do
    genre = Genre.new(name: 'test genre', eligibility_counter: 0, posts_count: 0)
    genre.save
    genre = Genre.find_by name: 'test genre'
    assert_response :success, genre
  end
  test "Update a genre" do
    genre = Genre.new(name: 'test genre', eligibility_counter: 0, posts_count: 0)
    genre.save
    genre = Genre.find_by name: 'test genre'
    genre.name = "mikuchan"
    genre.save
    genre = Genre.find_by name: 'mikuchan'
    assert_response :success, genre
  end
  test "Destroy a Genre" do
    genre = Genre.new(name: 'test genre', eligibility_counter: 0, posts_count: 0)
    genre.save
    genre = Genre.find_by name: 'test genre'
    assert_response :success, genre.destroy
  end
end
