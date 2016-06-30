# Comments Controller: JSON response through Active Model Serializers
class Api::V1::InnerCommentsController < ApiController
  respond_to :json

  # Render all InnerComments using InnerCommentSerializer.
  def index
    json_render_all(InnerComment, :empathy_level)
  end

  # Render the specified InnerComment using InnerCommentSerializer.
  def show
    render json: innerComment
  end
  
  # Render the created InnerComment using InnerCommentSerializer and the AMS Deserialization.
  def create
    json_create(innerComment_params, InnerComment)
  end

  # Render the updated InnerComment using InnerCommentSerializer and the AMS Deserialization.
  def update
    json_update(innerComment, innerComment_params, InnerComment)
  end

  # Destroy InnerComment from the AMS Deserialization params.
  def destroy
      render json: {}, status: :method_not_allowed
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
