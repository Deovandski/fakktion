# Topics Controller: JSON response through Active Model Serializers
class Api::V1::TopicsController < ApiController
  respond_to :json

  # Render all Topics using TopicSerializer.
  def index
    render json: Topic.all
  end

  # Render the specified Topic using TopicSerializer.
  def show
    render json: topic
  end

  # Render the created Topic using TopicSerializer and the AMS Deserialization.
  def create
    topic = Topic.create(topic_params)
    render json: topic
  end

  # Render the updated Topic using TopicSerializer and the AMS Deserialization.
  def update
    if topic.update(topic_params)
      render json: topic, status: :ok
    else
      render json: topic.errors, status: :unprocessable_entity
    end
  end
  
  # Destroy Topic from the AMS Deserialization params.
  def destroy
    if topic.destroy
      render json: {}, status: :no_content
    else
      render json: topic.errors, status: :unprocessable_entity
    end
  end

  private

  # Topic object from the Deserialization params if there is an id.
  def topic
    Topic.find(params[:id])
  end

  # AMS Topic Deserialization.
  def topic_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
