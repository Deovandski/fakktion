class Api::V1::CommentsController < ApplicationController
	respond_to :json # default to Active Model Serializers

	def index
		respond_with Comment.all
	end

	def show
		respond_with comment
	end

	def create
		respond_with :api, :v1, Comment.create(comment_params)
	end

	def update
		respond_with comment.update(comment_params)
	end

	def destroy
		respond_with comment.destroy
	end

	private

	def comment
		Comment.find(params[:id])
	end

	def comment_params
		params.require(:comment).permit(:text, :user_id, :post_id, :empathy_level, :soft_delete_date, :soft_delete, :hidden)
	end
end
