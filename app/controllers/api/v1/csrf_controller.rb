class Api::V1::CsrfController < ApplicationController
	respond_to :json
	def index
		render json: { request_forgery_protection_token => form_authenticity_token }.to_json
	end
end
