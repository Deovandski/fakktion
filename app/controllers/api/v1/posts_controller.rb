# Posts Controller: JSON response through Active Model Serializers
class Api::V1::PostsController < ApplicationController
	respond_to :json 

	def index
		render json: Post.all
	end

	def show
		post.increment!(:views_count)
		render json: post
	end

	def create
		render json: Post.create(post_params)
	end

	def update
		if post.update(post_params)
			render json: post, status: :ok
		else
			render json: post.errors, status: :unprocessable_entity
		end
	end

	def destroy
		render json: post.destroy
	end

	private
	def post
		Post.find(params[:id])
	end

	def post_params
		ActiveModel::Serializer::Adapter::JsonApi::Deserialization.parse(params.to_h)
	end
end
