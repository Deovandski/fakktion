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
		render json: Topic.create(topic_params)
	end

	def update
		render json: topic.update(topic_params)
	end

	def destroy
		render json: topic.destroy
	end

	private

	def topic
		Topic.find(params[:id])
	end

	def topic_params
		ActiveModel::Serializer::Adapter::JsonApi::Deserialization.parse(params.to_h)
	end
end
