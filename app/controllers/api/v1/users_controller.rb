# Users Controller: JSON response through Active Model Serializers
class Api::V1::UsersController < ApiController
  respond_to :json

  # Render all Users using UserSerializer.
  def index
    json_render_all(User, :display_name)
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
    tempUser.facebook_url = ""
    tempUser.twitter_url = ""
    tempUser.is_super_user = false
    tempUser.is_admin = false
    tempUser.is_legend = false
    tempUser.personal_message = "This person did not write anything here yet..."
    tempUser.save
    render json: tempUser
  end

  # Render the updated User using UserSerializer and the AMS Deserialization.
  def update
    # Check if password is blank, if so, clear :current_password
    # and update without password, else updates password.
    if current_user.id == user.id
      if user_params[:password].blank? || user_params[:current_password].blank?
        if user.email == user_params[:email]
          user.update_without_password(user_params.except(:current_password,:password))
        else
          user.update_without_password(user_params.except(:current_password,:password, :email))
        end
        render json: user, status: :ok
      elsif user.update_with_password(user_params)
        render json: user, status: :ok
      else
        render json: user.errors, status: :unprocessable_entity
      end
    else
      render json: user.errors, status: :forbidden
    end
  end

  # Destroy User from the AMS Deserialization params.
  def destroy
      render json: {}, status: :method_not_allowed
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
