# Users Controller: JSON response through Active Model Serializers
class Api::V1::TokensController < ApiController
	respond_to :json

	def create
		render json: token_email, serializer: TokenSerializer, status: 200
	end

	private
	
	def token_email
		User.find(user_params[:id])
	end
	
	def user_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
