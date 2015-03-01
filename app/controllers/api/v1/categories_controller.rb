class Api::V1::CategoriesController < ApplicationController
  respond_to :json # default to Active Model Serializers
  def index
    respond_with Categorie.all
  end

  def show
    respond_with Categorie.find(params[:id])
  end

  def create
    respond_with :api, :v1, Categorie.create(categorie_params)
  end

  def update
    respond_with Categorie.update(params[:id], categorie_params)
  end

  def destroy
    respond_with Categorie.destroy(params[:id])
  end

  private
  def categorie_params
    params.require(:categorie).permit(:category_name) # only allow these for now
  end
end
