class Api::V1::CategoriesController < ApplicationController
  respond_to :json # default to Active Model Serializers
  
  def index
    respond_with Categorie.all
  end

  def show
    respond_with categorie
  end

  def create
    respond_with :api, :v1, Categorie.create(categorie_params)
  end

  def update
    respond_with categorie.update(categorie_params)
  end

  def destroy
    respond_with categorie.destroy
  end

  private
  
  def categorie
    Categorie.find(params[:id])
  end
  
  def categorie_params
    params.require(:categorie).permit(:name, :usage_count) # only allow these for now
  end
end
