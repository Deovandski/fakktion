# Admin Messages Controller: JSON response through Active Model Serializers
class Api::V1::AdminMessagesController < ApiController
	respond_to :json

	def index
		render json: AdminMessage.all
	end

	def show
		render json: adminMessage
	end

	def create
		adminMessage = AdminMessage.create(adminMessage_params)
		render json: adminMessage
	end

	def update
		tempAdminMessage = adminMessage.update(adminMessage_params)
		render json: tempAdminMessage
	end

	def destroy
		# Proper Way To Destroy?
		if adminMessage.destroy
			render json: {}, status: :no_content
		else
			render json: adminMessage.errors, status: :unprocessable_entity
		end
	end

	private

	def adminMessage
		AdminMessage.find(params[:id])
	end

	def adminMessage_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
