# Genres Controller: JSON response through Active Model Serializers
class Api::V1::GenresController < ApiController
  respond_to :json

  # Render all Genres using GenreSerializer.
  def index
    render json: Genre.all
  end

  # Render the specified Genre using GenreSerializer.
  def show
    render json: genre
  end

  # Render the created Genres using GenreSerializer and the AMS Deserialization.
  def create
    genre = Genre.new(genre_params)
    if genre.save
      render json: genre, status: :ok
    else
      render json: genre.errors, status: :unprocessable_entity
    end
  end

  # Render the updated Genre using GenreSerializer and the AMS Deserialization.
  def update
    if genre.update(genre_params)
      render json: genre, status: :ok
    else
      render json: genre.errors, status: :unprocessable_entity
    end
  end

  # Destroy Genre from the AMS Deserialization params.
  def destroy
    if genre.destroy
      render json: {}, status: :no_content
    else
      render json: genre.errors, status: :unprocessable_entity
    end
  end

  private

  # Genre object from the Deserialization params if there is an id.
  def genre
    Genre.find(params[:id])
  end

  # AMS Genre Deserialization.
  def genre_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
