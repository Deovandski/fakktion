require 'test_helper'

class Api::V1::PostsControllerTest < ActionController::TestCase
	test "should get index" do
		get :index
		# https://stackoverflow.com/questions/35520288/v0-10-rc4-expecting-postserializer-on-test-got-activemodelserializercoll
		#assert_serializer "PostSerializer"
	end
end
