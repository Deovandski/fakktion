class Api::V1::CategoriesController < MasterApiController
	respond_to :json

	def index
		render json: Category.all
	end

	def show
		render json: category
	end

	def create
		render json: Category.create(category_params)
	end

	def update
		render json: category.update(categorie_params)
	end

	def destroy
		render json: category.destroy
	end

	private

	def category
		Category.find(params[:id])
	end

	def category_params
		#Deserialization issues for relationships. Waiting for #950 https://github.com/rails-api/active_model_serializers/pull/950
		params.require(:data).require(:attributes).permit(:name, :posts_count)
	end
end
