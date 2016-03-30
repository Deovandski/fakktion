# Posts Controller: JSON response through Active Model Serializers
class Api::V1::PostsController < ApiController
  respond_to :json 

  # Render all Posts using PostSerializer.
  def index
    json_render_all(Post, :importance)
  end

  # Render the specified Post using PostSerializer.
  def show
    render json: post
  end

  # Render the created Post using PostSerializer and the AMS Deserialization.
  def create
    json_create_and_sanitize(post_params, Post)
  end

  # Render the updated Post using PostSerializer and the AMS Deserialization.
  def update
    json_update_and_sanitize(post,post_params)
  end

  # Destroy Post from the AMS Deserialization params.
  def destroy
    json_destroy(post)
  end
  
  private
  
  # Post object from the Deserialization params if there is an id.
  def post
    Post.find(params[:id])
  end

  # AMS Post Deserialization.
  def post_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
