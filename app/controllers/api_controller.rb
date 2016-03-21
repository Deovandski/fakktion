# Api Controller: Set options for all v1 API controllers. 
class ApiController < ActionController::Base
  prepend_before_filter :disable_devise_trackable

  # Disable CSRF for all API Requests...
  # https://stackoverflow.com/questions/34833100/csrf-token-authenticity-issues-with-ember-cli-rails-alongside-devise
  skip_before_action :verify_authenticity_token
  
  protected
  # Disable Devise Trackable for all API requests
  # Devise Trackable still tracks login since Devise is hooked to ApplicationController.
  def disable_devise_trackable
    request.env["devise.skip_trackable"] = true
  end
end
