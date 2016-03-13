# Categories Controller: JSON response through Active Model Serializers
class Api::V1::CategoriesController < ApiController
	respond_to :json

	def index
		render json: Category.all
	end

	def show
		render json: category
	end

	def create
		category = Category.create(category_params)
		render json: category
	end

	def update
		if category.update(category_params)
			render json: category, status: :ok
		else
			render json: category.errors, status: :unprocessable_entity
		end
	end
	
	def destroy
		# Proper Way To Destroy?
		if category.destroy
			render json: {}, status: :no_content
		else
			render json: category.errors, status: :unprocessable_entity
		end
	end

	private

	def category
		Category.find(params[:id])
	end

	def category_params
		ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
	end
end
