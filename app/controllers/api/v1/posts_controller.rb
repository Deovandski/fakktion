# Posts Controller: JSON response through Active Model Serializers
class Api::V1::PostsController < ApiController
  respond_to :json 

  def index
    render json: Post.all
  end

  def show
    post.increment!(:views_count)
    render json: post
  end

  def create
    post = Post.create(post_params)
    render json: post
  end

  def update
    if post.update(post_params)
      render json: post, status: :ok
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # Proper Way To Destroy?
    if post.destroy
      render json: {}, status: :no_content
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  private
  def post
    Post.find(params[:id])
  end

  def post_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
