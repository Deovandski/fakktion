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
    if category_params[:name].length < 10
    json_create(category_params, Category)
    else
      return render json: {}, status: :unprocessable_entity
    end
  end

  # Render the updated Category using CategoriesSerializer and the AMS Deserialization.
  def update
    if category_params[:name].length < 10
      json_update(category,category_params)
    else
      return render json: {}, status: :unprocessable_entity
    end
  end

  # Destroy Categories from the AMS Deserialization params.
  def destroy
      render json: {}, status: :method_not_allowed
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
