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
    genre = Genre.new(genre_params)
    if genre.save
      render json: genre, status: :ok
    else
      render json: genre.errors, status: :unprocessable_entity
    end
  end

  def update
    if genre.update(genre_params)
      render json: genre, status: :ok
    else
      render json: genre.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # Proper Way To Destroy?
    if genre.destroy
      render json: {}, status: :no_content
    else
      render json: genre.errors, status: :unprocessable_entity
    end
  end

  private

  def genre
    Genre.find(params[:id])
  end

  def genre_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
