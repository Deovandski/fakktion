# Fact Types Controller: JSON response through Active Model Serializers
class Api::V1::FactTypesController < ApiController
	respond_to :json
	
	def index
		render json: FactType.all
	end

	def show
		render json: factType
	end

	def create
		factType = Topic.create(factType_params)
		render json: factType
	end

	def update
		tempFactType = factType.update(factType_params)
		render json: tempFactType
	end

	def destroy
		# Proper Way To Destroy?
		if factType.destroy
			render json: {}, status: :no_content
		else
			render json: factType.errors, status: :unprocessable_entity
		end
	end

	private

	def factType
		FactType.find(params[:id])
	end

	def factType_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
