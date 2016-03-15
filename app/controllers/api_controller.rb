# Api Controller: Set options for all v1 API controllers. 
class ApiController < ActionController::Base
  # Devise Trackable still tracks login since Devise is hooked to ApplicationController.
  prepend_before_filter :disable_devise_trackable

  # Disable CSRF for all API Requests...
  # https://stackoverflow.com/questions/34833100/csrf-token-authenticity-issues-with-ember-cli-rails-alongside-devise
  skip_before_action :verify_authenticity_token
  
  before_action :authenticate_user_from_token!

  def index
    render layout: false
  end

  protected
  def disable_devise_trackable
    request.env["devise.skip_trackable"] = true
  end
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
