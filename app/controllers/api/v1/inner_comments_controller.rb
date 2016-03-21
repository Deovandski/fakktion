# Comments Controller: JSON response through Active Model Serializers
class Api::V1::InnerCommentsController < ApiController
  respond_to :json

  # Render all InnerComments using InnerCommentSerializer.
  def index
    render json: InnerComment.all
  end

  # Render the specified InnerComment using InnerCommentSerializer.
  def show
    render json: innerComment
  end

  # Render the created InnerComment using InnerCommentSerializer and the AMS Deserialization.
  def create
    innerComment = InnerComment.create(innerComment_params)
    render json: innerComment
  end

  # Render the updated InnerComment using InnerCommentSerializer and the AMS Deserialization.
  def update
    if innerComment.update(innerComment_params)
      render json: innerComment, status: :ok
    else
      render json: innerComment.errors, status: :unprocessable_entity
    end
  end
  

  # Destroy InnerComment from the AMS Deserialization params.
  def destroy
    if innerComment.destroy
      render json: {}, status: :no_content
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  # InnerComment object from the Deserialization params if there is an id.
  def innerComment
    InnerComment.find(params[:id])
  end

  # AMS InnerComment Deserialization.
  def innerComment_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
