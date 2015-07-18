class Api::V1::PostsController < ApplicationController
	#skip_before_filter :verify_authenticity_token
	respond_to :json # default to Active Model Serializers
  
  def index
    respond_with Post.all
  end

  def show
    respond_with Post.find(params[:id])
  end

  def create
    respond_with :api, :v1, Post.create(post_params)
  end

  def update
    respond_with Post.update(params[:id], post_params)
  end

  def destroy
    respond_with Post.destroy(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:genres_id, :text, :views_count, :title, :categories_id, :topics_id, :user_id, :genre_id, :topic_id, :categorie_id, :fact_type_id, :fact_link, :fiction_link, :importance, :soft_delete, :soft_delete_date, :hidden)
  end
end
