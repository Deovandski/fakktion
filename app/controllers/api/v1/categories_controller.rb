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
		ActiveModel::Serializer::Adapter::JsonApi::Deserialization.parse(params.to_h)
	end
end
