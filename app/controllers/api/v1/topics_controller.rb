# Topics Controller: JSON response through Active Model Serializers
class Api::V1::TopicsController < ApiController
	respond_to :json

	def index
		render json: Topic.all
	end

	def show
		render json: topic
	end

	def create
		topic = Topic.create(topic_params)
		render json: topic
	end

	def update
		tempTopic = topic.update(topic_params)
		render json: tempTopic
	end

	def destroy
		# Proper Way To Destroy?
		if topic.destroy
			render json: {}, status: :no_content
		else
			render json: topic.errors, status: :unprocessable_entity
		end
	end

	private

	def topic
		Topic.find(params[:id])
	end

	def topic_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
