class Api::V1::PostingDatesController < ApplicationController
  respond_to :json # default to Active Model Serializers
  
  def index
    respond_with PostingDate.all
  end

  def show
    respond_with postingDate
  end

  def create
    respond_with :api, :v1, PostingDate.create(postingDate_params)
  end

  def update
    respond_with postingDate.update(postingDate_params)
  end

  def destroy
    respond_with postingDate.destroy
  end

  private
  
  def postingDate
    PostingDate.find(params[:id])
  end
  
  def postingDate_params
    params.require(:posting_date).permit(:fact_posting_date) # only allow these for now
  end
end
