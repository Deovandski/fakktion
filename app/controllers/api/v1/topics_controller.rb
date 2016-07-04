# Topics Controller: JSON response through Active Model Serializers
class Api::V1::TopicsController < ApiController
  respond_to :json

  # Render all Topics using TopicSerializer.
  def index
    json_render_all(Topic, :name)
  end

  # Render the specified Topic using TopicSerializer.
  def show
    render json: topic
  end

  # Render the created Topic using TopicSerializer and the AMS Deserialization.
  def create
    json_create(topic_params, Topic)
  end

  # Render the updated Topic using TopicSerializer and the AMS Deserialization.
  def update
    json_update(topic,topic_params, Topic)
  end

  # Destroy Topic from the AMS Deserialization params.
  def destroy
      render json: {}, status: :method_not_allowed
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
