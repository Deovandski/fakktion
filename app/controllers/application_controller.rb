# Application Controller: User Authentication from token control
# + CSRF protection for all requests.
class ApplicationController < ActionController::Base

	# Full CSRF protection is not working....
	#protect_from_forgery with: :null_session
	# Replace with protect_from_forgery with: :exception later on...
	skip_before_action :verify_authenticity_token
	
	before_action :authenticate_user_from_token!

	def index
		render layout: false
	end

	protected

	def authenticate_user_from_token!
		authenticate_with_http_token do |token, options|
			user_email = options[:email].presence
			user = user_email && User.find_by_email(user_email)

			if user && Devise.secure_compare(user.authentication_token, token)
				sign_in user, store: false
			end
		end
	end
end
