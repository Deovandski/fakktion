class Api::V1::TopicsController < ApplicationController
	respond_to :json

	def index
		respond_with Topic.all
	end

	def show
		respond_with topic
	end

	def create
		respond_with :api, :v1, Topic.create(topic_params)
	end

	def update
		respond_with topic.update(topic_params)
	end

	def destroy
		respond_with topic.destroy
	end

	private

	def topic
		Topic.find(params[:id])
	end

	def topic_params
		params.require(:topic).permit(:name, :usage_count) # only allow these for now
	end
end
