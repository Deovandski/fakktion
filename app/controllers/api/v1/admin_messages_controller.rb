# Admin Messages Controller: JSON response through Active Model Serializers
class Api::V1::AdminMessagesController < ApiController
  respond_to :json
  
  # Render all AdminMessages using AdminMessageSerializer.
  def index
    render json: AdminMessage.all
  end

  # Render the specified AdminMessage using AdminMessageSerializer.
  def show
    render json: adminMessage
  end

  # Render the created AdminMessage using AdminMessageSerializer and the AMS Deserialization.
  def create
    adminMessage = AdminMessage.create(adminMessage_params)
    render json: adminMessage
  end
  
  # Render the updated AdminMessage using AdminMessageSerializer and the AMS Deserialization.
  def update
    if adminMessage.update(adminMessage_params)
      render json: adminMessage, status: :ok
    else
      render json: adminMessage.errors, status: :unprocessable_entity
    end
  end

  # Destroy AdminMessage from the AMS Deserialization params.
  def destroy
    if adminMessage.destroy
      render json: {}, status: :no_content
    else
      render json: adminMessage.errors, status: :unprocessable_entity
    end
  end

  private

  # AdminMessage object from the Deserialization params if there is an id.
  def adminMessage
    AdminMessage.find(params[:id])
  end

  # AMS AdminMessage Deserialization.
  def adminMessage_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
