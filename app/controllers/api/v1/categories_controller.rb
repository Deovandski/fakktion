class Api::V1::CategoriesController < ApplicationController
	respond_to :json # default to Active Model Serializers

	def index
		respond_with Category.all
	end

	def show
		respond_with category
	end

	def create
		respond_with :api, :v1, Category.create(category_params)
	end

	def update
		respond_with category.update(categorie_params)
	end

	def destroy
		respond_with category.destroy
	end

	private

	def category
		Category.find(params[:id])
	end

	def category_params
		params.require(:category).permit(:name, :posts_count) # only allow these for now
	end
end
