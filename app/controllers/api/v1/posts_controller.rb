class Api::V1::PostsController < MasterApiController
	respond_to :json # default to Active Model Serializers

	def index
		render json: Post.all
	end

	def show
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
		params.require(:post).permit(:genre_id, :text, :views_count, :title, :category_id, :topic_id, :user_id, :fact_type_id, :fact_link, :fiction_link, :importance, :soft_delete, :soft_delete_date, :hidden, :comments_count)
	end
end
