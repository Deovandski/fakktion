class Api::V1::CommentsController < ApplicationController
  respond_to :json # default to Active Model Serializers
  
  def index
    respond_with Comment.all
  end

  def show
    respond_with comment
  end

  def create
    respond_with :api, :v1, comment.create(comment_params)
  end

  def update
    respond_with comment.update(comment_params)
  end

  def destroy
    respond_with comment.destroy
  end

  private
  
  def comment
    Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:text) # only allow these for now
  end
end
