class Api::V1::AdminMessagesController < MasterApiController
	respond_to :json

	def index
		render json: AdminMessage.all
	end

	def show
		render json: adminMessage
	end

	def create
		render json: AdminMessage.create(adminMessage_params)
	end

	def update
		render json: adminMessage.update(adminMessage_params)
	end

	def destroy
		render json: adminMessage.destroy
	end

	private

	def adminMessage
		AdminMessage.find(params[:id])
	end

	def adminMessage_params
		#Deserialization issues for relationships. Waiting for #950 https://github.com/rails-api/active_model_serializers/pull/950
		params.require(:data).require(:attributes).permit(:message, :title)
	end
end
