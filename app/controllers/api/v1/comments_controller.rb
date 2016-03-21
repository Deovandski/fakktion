# Comments Controller: JSON response through Active Model Serializers
# NOTES:
# Response needs to include the JSON serialization of the object instead of only a 200 OK.
class Api::V1::CommentsController < ApiController
  respond_to :json

  # Render all Comments using CommentSerializer.
  def index
    render json: Comment.all
  end

  # Render the specified Comment using CommentSerializer.
  def show
    render json: comment
  end

  # Render the created Comment using CommentSerializer and the AMS Deserialization.
  def create
    comment = Comment.create(comment_params)
    render json: comment
  end
  
  # Render the updated Comment using CommentSerializer and the AMS Deserialization.
  def update
    if comment.update(comment_params)
      render json: comment, status: :ok
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end
  
  # Destroy Comment from the AMS Deserialization params.
  def destroy
    if comment.destroy
      render json: {}, status: :no_content
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  # Comment object from the Deserialization params if there is an id.
  def comment
    Comment.find(params[:id])
  end

  # AMS Comment Deserialization.
  def comment_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
