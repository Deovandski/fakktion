# Comments Controller: JSON response through Active Model Serializers
# NOTES:
# Response needs to include the JSON serialization of the object instead of only a 200 OK.
class Api::V1::CommentsController < ApiController
  respond_to :json

  # Render all Comments using CommentSerializer.
  def index
    json_render_all(Comment, :empathy_level)
  end

  # Render the specified Comment using CommentSerializer.
  def show
    render json: comment
  end

  # Render the created Comment using CommentSerializer and the AMS Deserialization.
  def create
    json_create_and_sanitize(comment_params, Comment)
  end

  # Render the updated Comment using CommentSerializer and the AMS Deserialization.
  def update
    json_update_and_sanitize(comment,comment_params)
  end

  # Destroy Comment from the AMS Deserialization params.
  def destroy
    json_destroy(comment)
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
