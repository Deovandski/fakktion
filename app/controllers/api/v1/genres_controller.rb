class GenresController < ApplicationController
# TODO: Check to see if Api::V1:: is required...

  respond_to :json # default to Active Model Serializers | 
  def index
    respond_with Genre.all
  end

  def show
    respond_with Genre.find(params[:id])
  end

  def create
    respond_with :api, :v1, Genre.create(genre_params)
  end

  def update
    respond_with Genre.update(params[:id], genre_params)
  end

  def destroy
    respond_with Genre.destroy(params[:id])
  end

  private
  def genre_params
    params.require(:post).permit(:genre_name) # only allow these for now
  end
end
