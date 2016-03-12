# Comments Controller: JSON response through Active Model Serializers
class Api::V1::InnerCommentsController < ApiController
	respond_to :json

	def index
		render json: InnerComment.all
	end

	def show
		render json: innerComment
	end

	def create
		innerComment = InnerComment.create(comment_params)
		render json: comment
	end

	def update
		tempInnerComment = innerComment.update(comment_params)
		render json: tempInnerComment
	end

	def destroy
		# Proper Way To Destroy?
		if innerComment.destroy
			render json: {}, status: :no_content
		else
			render json: comment.errors, status: :unprocessable_entity
		end
	end

	private

	def innerComment
		InnerComment.find(params[:id])
	end

	def comment_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
