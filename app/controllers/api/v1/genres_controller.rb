# Genres Controller: JSON response through Active Model Serializers
class Api::V1::GenresController < ApiController
	respond_to :json

	def index
		render json: Genre.all
	end

	def show
		render json: genre
	end

	def create
		render json: Genre.create(genre_params)
	end

	def update
		render json: genre.update(genre_params)
	end

	def destroy
		render json: genre.destroy
	end

	private

	def genre
		Genre.find(params[:id])
	end

	def genre_params
		ActiveModel::Serializer::Adapter::JsonApi::Deserialization.parse(params.to_h)
	end
end
