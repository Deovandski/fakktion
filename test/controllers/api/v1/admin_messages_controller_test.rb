require 'test_helper'

class Api::V1::AdminMessagesControllerTest < ActionController::TestCase
  # Called before every test
  setup do
    @request.headers["Content-Type"] = "application/json; charset=utf-8"
    @adminMessagedAuthor = User.first
    @testAdminMessage = AdminMessage.new(title: 'testing title', message: "qwertyuiopoiuytrewq", user: @adminMessagedAuthor)
    @testAdminMessage.save
  end
  # Called after test
  def teardown
    @testAdminMessage = nil
    @apiAdminMessage = nil
    @genreSerialized = nil
    @adminMessagedAuthor = nil
  end
  test "AdminMessages - API - Get Index" do
    get :index
    assert_response_schema('adminMessages/index.json')
  end
  test "AdminMessages - API - Serializer Validation" do
    sampleSenre = AdminMessage.new
    serializer = ActiveModel::Serializer.serializer_for(sampleSenre)
    assert_equal AdminMessageSerializer, serializer
  end
  test "AdminMessages - API - Create 200" do
    apiAdminMessage = AdminMessage.new(title: 'luka! luka! luka!', message: "qwertyuiopoiuytrewq", user: @adminMessagedAuthor)
    assert_difference('AdminMessage.count', +1) do
      post :create, ActiveModelSerializers::SerializableResource.new(apiAdminMessage).as_json
    end
  end
  test "AdminMessages - API - Create 422" do
      post :create, ActiveModelSerializers::SerializableResource.new(@testAdminMessage).as_json
      assert_response(422)
  end
  test "AdminMessages - API - SHOW 200" do
    get :show, id: @testAdminMessage
    assert_response_schema('adminMessages/show.json')
  end
  test "AdminMessages - API - UPDATE 200" do
    adminMessage = AdminMessage.find_by title: 'testing title'
    adminMessage.title = "mikuchan"
    tempAdminMessage = ActiveModelSerializers::SerializableResource.new(adminMessage).serializable_hash
    post :update, tempAdminMessage.merge(id: adminMessage)
    genreUpdated = AdminMessage.find_by title: 'mikuchan'
    assert_response :success, genreUpdated
  end
  test "AdminMessages - API - UPDATE 422" do
    adminMessage = AdminMessage.find_by title: 'testing title'
    adminMessage.title = "qwertyuiop"
    adminMessage1 = AdminMessage.new(title: 'testing title #1', message: "qwertyuiopoiuytrewq", user: @adminMessagedAuthor)
    adminMessage1.save
    adminMessage1.title = "qwertyuiop"
    tempAdminMessage = ActiveModelSerializers::SerializableResource.new(adminMessage).serializable_hash
    tempAdminMessage1 = ActiveModelSerializers::SerializableResource.new(adminMessage1).serializable_hash
    post :update, tempAdminMessage.merge(id: adminMessage)
    post :update, tempAdminMessage1.merge(id: adminMessage1)
    assert_response(422)
  end
  test "AdminMessages - API - DELETE 200" do
    assert_difference('AdminMessage.count', 0) do
      delete :destroy, id: @testAdminMessage
    end
  end
end
