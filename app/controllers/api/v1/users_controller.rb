# Users Controller: JSON response through Active Model Serializers
class Api::V1::UsersController < ApiController
  respond_to :json

  # Render all Users using UserSerializer.
  def index
    render json: User.all
  end

  # Render the specified User using UserSerializer.
  def show
    render json: user
  end

  # Render the created User using UserSerializer and the AMS Deserialization.
  def create
    tempUser = User.new(user_params.except(:current_password))
    tempUser.sign_in_count = 0
    tempUser.webpage_url = ""
    tempUser.is_banned = false
    tempUser.facebook_url = ""
    tempUser.twitter_url = ""
    tempUser.is_admin = false
    tempUser.personal_message = "This person did not write anything here yet..."
    tempUser.save
    render json: tempUser
  end

  # Render the updated User using UserSerializer and the AMS Deserialization.
  def update
    # Check if password is blank, if so, clear :current_password
    # and update without password, else updates password.
    if user_params[:password].blank? || user_params[:current_password].blank?
      user.update_without_password(user_params.except(:current_password,:password))
      render json: user
    else
      if user.update_with_password(user_params)
        render json: user, status: :ok
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  end

  # Destroy User from the AMS Deserialization params.
  def destroy
    if user.destroy
      render json: {}, status: :no_content
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private
  
  # User object from the Deserialization params if there is an id.
  def user
    User.find(params[:id])
  end
  
  # AMS User Deserialization.
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
