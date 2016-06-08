# Fact Types Controller: JSON response through Active Model Serializers
class Api::V1::FactTypesController < ApiController
  respond_to :json

  # Render all FactTypes using FactTypeSerializer.
  def index
    json_render_all(FactType, :name)
  end

  # Render the specified FactType using FactTypeSerializer.
  def show
    render json: factType
  end

  # Render the created FactType using FactTypeSerializer and the AMS Deserialization.
  def create
    if factType_params[:name].length < 10
      json_create(factType_params, FactType)
    else
      return render json: {}, status: :unprocessable_entity
    end
  end

  # Render the updated FactType using FactTypeSerializer and the AMS Deserialization.
  def update
    if factType_params[:name].length < 10
    json_update(factType,factType_params)
    else
      return render json: {}, status: :unprocessable_entity
    end
  end

  # Destroy FactType from the AMS Deserialization params.
  def destroy
      render json: {}, status: :method_not_allowed
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
