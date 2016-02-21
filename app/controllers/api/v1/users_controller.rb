# Users Controller: JSON response through Active Model Serializers
class Api::V1::UsersController < ApiController
	respond_to :json

	def index
		render json: User.all
	end

	def show
		render json: user
	end

	def create
		params[:sign_in_count] = 0
		params[:webpage_url] = ""
		params[:is_banned] = false
		params[:facebook_url] = ""
		params[:twitter_url] = ""
		params[:is_admin] = false
		params[:is_super_user] = false
		params[:personal_message] = ""
		render json: User.create(user_params)
	end

	def update
		#Remove password parameters if there was no request
		#However, keep :current_password since it is always checked.
		if user_params[:password].blank?
			user_params.delete(:password)
			user_params.delete(:current_password)
		end
		if needs_password?(user, user_params)
			render json: user.update_with_password(user_params)
		else
			render json: user.update_without_password(user_params)
		end
	end

	def destroy
		render json: user.destroy
	end

	private
	
	def user
		User.find(params[:id])
	end
	
	def needs_password?(user, params)
		params[:password].present?
	end
	
	def user_params
		ActiveModel::Serializer::Adapter::JsonApi::Deserialization.parse(params.to_h)
	end
end
