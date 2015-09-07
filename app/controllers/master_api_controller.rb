class MasterApiController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	# CSRF Somehow not working for API with "Can't verify CSRF token authenticity" errors
	# protect_from_forgery with: :null_session
	
	# For Alpha and Beta, skip_before_filter will be used...
	skip_before_filter :verify_authenticity_token
end
