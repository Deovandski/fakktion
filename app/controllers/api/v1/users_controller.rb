class Api::V1::UsersController < ApplicationController
	respond_to :json

	def index
		respond_with User.all
	end

	def show
		respond_with user
	end

	def create
		respond_with :api, :v1, User.create(user_params)
	end

	def update
		if user_params[:password].blank?
			user_params.delete(:password)
			user_params.delete(:password_confirmation)
		end
		successfully_updated =  if needs_password?(user, user_params)
									user.update(user_params)
								else
									user.update_without_password(user_params)
								end
		if successfully_updated
			respond_with user, status: :ok
		else
			respond_with user.errors, status: :unprocessable_entity
		end
	end

	def destroy
		respond_with user.destroy
	end

	private
	
	def user
		User.find(params[:id])
	end
	
	def needs_password?(user, params)
		params[:password].present?
	end
	
	def user_params
		params.require(:user).permit(:id, :show_full_name, :full_name, :display_name, :email, :date_of_birth, :gender, :facebook_url, :twitter_url, :personal_message, :webpage_url, :is_banned, :is_banned_date, :legal_terms_read, :privacy_terms_read, :is_admin, :is_super_user, :sign_in_count, :password, :number_of_comments, :number_of_posts, :last_sign_in_at, :reset_password_sent_at, :reset_password_token, :updated_at, :created_at)
	end
end
