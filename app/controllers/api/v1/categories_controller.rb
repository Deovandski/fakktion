# Categories Controller: JSON response through Active Model Serializers
class Api::V1::CategoriesController < ApiController
  respond_to :json

  # Render all Categories using CategoriesSerializer.
  def index
    render json: Category.all
  end

  # Render the specified Category using CategoriesSerializer.
  def show
    render json: category
  end

  # Render the created Category using CategoriesSerializer and the AMS Deserialization.
  def create
    category = Category.create(category_params)
    render json: category
  end

  # Render the updated Category using CategoriesSerializer and the AMS Deserialization.
  def update
    if category.update(category_params)
      render json: category, status: :ok
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end
  
  # Destroy Categories from the AMS Deserialization params.
  def destroy
    if category.destroy
      render json: {}, status: :no_content
    else
      render json: category.errors, status: :unprocessable_entity
    end
  end

  private

  # Categories object from the Deserialization params if there is an id.
  def category
    Category.find(params[:id])
  end

  # AMS Categories Deserialization.
  def category_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
