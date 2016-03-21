# Fact Types Controller: JSON response through Active Model Serializers
class Api::V1::FactTypesController < ApiController
  respond_to :json

  # Render all FactTypes using FactTypeSerializer.
  def index
    render json: FactType.all
  end

  # Render the specified FactType using FactTypeSerializer.
  def show
    render json: factType
  end

  # Render the created FactType using FactTypeSerializer and the AMS Deserialization.
  def create
    factType = Topic.create(factType_params)
    render json: factType
  end

  # Render the updated FactType using FactTypeSerializer and the AMS Deserialization.
  def update
    if factType.update(factType_params)
      render json: factType, status: :ok
    else
      render json: factType.errors, status: :unprocessable_entity
    end
  end
  
  # Destroy FactType from the AMS Deserialization params.
  def destroy
    if factType.destroy
      render json: {}, status: :no_content
    else
      render json: factType.errors, status: :unprocessable_entity
    end
  end

  private

  # FactType object from the Deserialization params if there is an id.
  def factType
    FactType.find(params[:id])
  end

  # AMS FactType Deserialization.
  def factType_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
