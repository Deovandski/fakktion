# Users Controller: JSON response through Active Model Serializers
class Api::V1::TokensController < ApiController
  respond_to :json

  def create
    if token_by_id == token_by_token
      if token_by_email == token_by_id
        render json: token_by_id, serializer: TokenSerializer, status: 200
      else
        render json: {}, status: 404
      end
    else
      render json: {}, status: 404
    end
  end

  private
  
  def token_by_id
    User.find(user_params[:id])
  end
  
  def token_by_email
    User.find_by(email: user_params[:email])
  end
  
  def token_by_token
    User.find_by(authentication_token: user_params[:authenticity_token])
  end
  
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
