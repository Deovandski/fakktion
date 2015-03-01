class FactTypesController < ApplicationController
  respond_to :json # default to Active Model Serializers
  def index
    respond_with FactType.all
  end

  def show
    respond_with FactType.find(params[:id])
  end

  def create
    respond_with :api, :v1, FactType.create(factType_params)
  end

  def update
    respond_with FactType.update(params[:id], factType_params)
  end

  def destroy
    respond_with FactType.destroy(params[:id])
  end

  private
  def factType_params
    params.require(:post).permit(:fact_name) # only allow these for now
  end
end
