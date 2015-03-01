class FactPostingsController < ApplicationController
  respond_to :json # default to Active Model Serializers
  def index
    respond_with FactPosting.all
  end

  def show
    respond_with FactPosting.find(params[:id])
  end

  def create
    respond_with :api, :v1, FactPosting.create(factPosting_params)
  end

  def update
    respond_with FactPosting.update(params[:id], factPosting_params)
  end

  def destroy
    respond_with FactPosting.destroy(params[:id])
  end

  private
  def factPosting_params
    params.require(:post).permit(:fact_posting_date) # only allow these for now
  end
end
