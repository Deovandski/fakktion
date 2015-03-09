class Api::V1::FactTypesController < ApplicationController
  respond_to :json # default to Active Model Serializers
  
  def index
    respond_with FactType.all
  end

  def show
    respond_with factType
  end

  def create
    respond_with :api, :v1, FactType.create(factType_params)
  end

  def update
    respond_with factType.update(factType_params)
  end

  def destroy
    respond_with factType.destroy
  end

  private
  
  def factType
    FactType.find(params[:id])
  end
  
  def factType_params
    params.require(:factType).permit(:fact_name) # only allow these for now
  end
end
