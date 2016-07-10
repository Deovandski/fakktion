# Admin Messages Controller: JSON response through Active Model Serializers
#class Api::V1::AdminMessagesController < ApiController
#  respond_to :json
#
#  # Render all AdminMessages using AdminMessageSerializer.
#  def index
#  render json: AdminMessages.all
#  end
#
#  # Render the specified AdminMessage using AdminMessageSerializer.
#  def show
#    render json: adminMessage
#  end
#
#  # Render the created AdminMessage using AdminMessageSerializer and the AMS Deserialization.
#  def create
#    json_create(adminMessage_params, AdminMessage)
#  end
#
#  # Render the updated AdminMessage using AdminMessageSerializer and the AMS Deserialization.
#  def update
#    json_update(adminMessage,adminMessage_params, AdminMessage)
#  end
#
#  # Destroy AdminMessage from the AMS Deserialization params.
#  def destroy
#      render json: {}, status: :method_not_allowed
#  end
#
#  private
#
#  # AdminMessage object from the Deserialization params if there is an id.
#  def adminMessage
#    AdminMessage.find(params[:id])
#  end
#
#  # AMS AdminMessage Deserialization.
#  def adminMessage_params
#    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
#  end
#end
