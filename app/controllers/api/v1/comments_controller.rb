# Comments Controller: JSON response through Active Model Serializers
# NOTES:
# Response needs to include the JSON serialization of the object instead of only a 200 OK.
class Api::V1::CommentsController < ApiController
	respond_to :json

	def index
		render json: Comment.all
	end

	def show
		render json: comment
	end

	def create
		comment = Comment.create(comment_params)
		render json: comment
	end

	def update
		comment.update(comment_params)
		render json: comment
	end

	def destroy
		# Proper Way To Destroy?
		if comment.destroy
			render json: {}, status: :no_content
		else
			render json: comment.errors, status: :unprocessable_entity
		end
	end

	private

	def comment
		Comment.find(params[:id])
	end

	def comment_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
