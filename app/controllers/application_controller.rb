# Application Controller: User Authentication from token control
# + CSRF protection for all Devise requests.
class ApplicationController < ActionController::Base
  before_action :authenticate_user_from_token!
  
  # Full CSRF protection
  protect_from_forgery with: :exception

  protected
  
  # Login User from token if there is one present on the Header.
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
