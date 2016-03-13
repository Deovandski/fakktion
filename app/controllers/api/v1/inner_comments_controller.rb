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
		innerComment = InnerComment.create(innerComment_params)
		render json: innerComment
	end

	def update
		if innerComment.update(innerComment_params)
			render json: innerComment, status: :ok
		else
			render json: innerComment.errors, status: :unprocessable_entity
		end
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

	def innerComment_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
