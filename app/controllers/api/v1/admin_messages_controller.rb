class Api::V1::AdminMessagesController < ApplicationController
	respond_to :json

	def index
		respond_with AdminMessage.all
	end

	def show
		respond_with adminMessage
	end

	def create
		respond_with :api, :v1, AdminMessage.create(adminMessage_params)
	end

	def update
		respond_with adminMessage.update(adminMessage_params)
	end

	def destroy
		respond_with adminMessage.destroy
	end

	private

	def adminMessage
		AdminMessage.find(params[:id])
	end

	def adminMessage_params
		params.require(:adminMessage).permit(:message,:title)
	end
end
