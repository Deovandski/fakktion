class Api::V1::UsersController < ApplicationController
	respond_to :json

	def index
		respond_with User.all
	end

	def show
		respond_with user
	end

	def create
		params[:user][:sign_in_count] = 0
		params[:user][:webpage_url] = ""
		params[:user][:is_banned] = false
		params[:user][:facebook_url] = ""
		params[:user][:twitter_url] = ""
		params[:user][:is_admin] = false
		params[:user][:is_super_user] = false
		params[:user][:personal_message] = ""
		respond_with :api, :v1, User.create(user_params)
	end

	def update
		#Remove password parameters if there was no request
		#However, keep :current_password since it is always checked.
		if user_params[:password].blank?
			user_params.delete(:password)
			user_params.delete(:current_password)
		end
		if needs_password?(user, user_params)
			respond_with user.update_with_password(user_params)
		else
			respond_with user.update_without_password(user_params)
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
		params.require(:user).permit(:id, :show_full_name, :full_name, :display_name, :email, :date_of_birth, :gender, :facebook_url, :twitter_url, :personal_message, :webpage_url, :is_banned, :is_banned_date, :legal_terms_read, :privacy_terms_read, :is_admin, :is_super_user, :sign_in_count, :password, :last_sign_in_at, :reset_password_sent_at, :reset_password_token, :updated_at, :created_at, :current_password, :posts_count, :comments_count, :admin_messages_count )
	end
end
