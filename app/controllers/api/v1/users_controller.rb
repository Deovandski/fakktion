class Api::V1::UsersController < ApplicationController
  respond_to :json # default to Active Model Serializers | 
  
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
    respond_with user.update(user_params)
  end

  def destroy
    respond_with user.destroy
  end
  
  private
    def user
      User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:id, :show_full_name, :full_name, :display_name, :email, :date_of_birth, :gender, :facebook_url, :twitter_url, :personal_message, :webpage_url, :is_banned, :is_banned_date, :legal_terms_read, :privacy_terms_read, :is_admin, :is_super_user, :sign_in_count, :password, :number_of_comments, :number_of_posts, :last_sign_in_at, :reset_password_sent_at, :reset_password_token, :updated_at, :created_at)
    end
end
