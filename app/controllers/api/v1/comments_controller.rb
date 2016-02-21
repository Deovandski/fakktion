# Comments Controller: JSON response through Active Model Serializers
class Api::V1::CommentsController < ApiController
	respond_to :json

	def index
		render json: Comment.all
	end

	def show
		render json: comment
	end

	def create
		render json: Comment.create(comment_params)
	end

	def update
		render json: comment.update(comment_params)
	end

	def destroy
		render json: comment.destroy
	end

	private

	def comment
		Comment.find(params[:id])
	end

	def comment_params
		ActiveModel::Serializer::Adapter::JsonApi::Deserialization.parse(params.to_h)
	end
end
