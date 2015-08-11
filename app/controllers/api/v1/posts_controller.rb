class Api::V1::PostsController < ApplicationController
	respond_to :json # default to Active Model Serializers

	def index
		respond_with Post.all
	end

	def show
		respond_with post
	end

	def create
		respond_with :api, :v1, Post.create(post_params)
	end

	def update
		if post.update(post_params)
			respond_with post, status: :ok
		else
			respond_with post.errors, status: :unprocessable_entity
		end
	end

	def destroy
		respond_with post.destroy
	end

	private
	def post
		Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:genres_id, :text, :views_count, :title, :categories_id, :topics_id, :user_id, :genre_id, :topic_id, :categorie_id, :fact_type_id, :fact_link, :fiction_link, :importance, :soft_delete, :soft_delete_date, :hidden)
	end
end
