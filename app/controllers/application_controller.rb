# Application Controller: User Authentication from token control
# + Mkay CSRF protection for all Devise requests.
class ApplicationController < ActionController::Base
  before_action :authenticate_user_from_token!

  # Full CSRF protection is not working....
  protect_from_forgery with: :null_session
  # Replace with protect_from_forgery with: :exception later on...

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
