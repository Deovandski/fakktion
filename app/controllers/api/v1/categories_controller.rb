# Categories Controller: JSON response through Active Model Serializers
class Api::V1::CategoriesController < ApiController
  respond_to :json

  # Render all Categories using CategoriesSerializer.
  def index
    json_render_all(Category, :name)
  end

  # Render the specified Category using CategoriesSerializer.
  def show
    render json: category
  end

  # Render the created Category using CategoriesSerializer and the AMS Deserialization.
  def create
    json_create(category_params, Category)
  end

  # Render the updated Category using CategoriesSerializer and the AMS Deserialization.
  def update
    json_update(category,category_params)
  end

  # Destroy Categories from the AMS Deserialization params.
  def destroy
    json_destroy(category)
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
