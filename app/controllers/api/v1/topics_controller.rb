class Api::V1::TopicsController < MasterApiController
	respond_to :json

	def index
		render json: Topic.all
	end

	def show
		render json: topic
	end

	def create
		render json: Topic.create(topic_params)
	end

	def update
		render json: topic.update(topic_params)
	end

	def destroy
		render json: topic.destroy
	end

	private

	def topic
		Topic.find(params[:id])
	end

	def topic_params
		params.require(:topic).permit(:name, :posts_count, :eligibility_counter) # only allow these for now
	end
end
