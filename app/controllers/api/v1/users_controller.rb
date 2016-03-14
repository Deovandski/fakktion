# Users Controller: JSON response through Active Model Serializers
class Api::V1::UsersController < ApiController
	respond_to :json

	def index
		render json: User.all
	end

	def show
		render json: user, serializer: UserTokenSerializer
	end

	def create
		tempUser = User.new(user_params)
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

	def update
		#Remove password parameters if there was no request
		#However, keep :current_password since it is always checked.
		if user_params[:password].blank?
			user_params.delete(:password)
			user_params.delete(:current_password)
		end
		if needs_password?(user, user_params)
			user.update_with_password(user_params)
			render json: user
		else
			user.update_without_password(user_params)
			render json: user
		end
	end

	def destroy
		# Proper Way To Destroy?
		if user.destroy
			render json: {}, status: :no_content
		else
			render json: user.errors, status: :unprocessable_entity
		end
	end

	private
	
	def user
		User.find(params[:id])
	end
	
	def needs_password?(user, params)
		params[:password].present?
	end
	
	def user_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
