# Application Controller: User Authentication from token control
# + CSRF protection for all HTTP requests. Check master_api for JSON.
class ApplicationController < ActionController::Base
	protect_from_forgery
	before_filter :authenticate_user_from_token!

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
