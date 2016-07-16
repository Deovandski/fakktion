# Comment Votes Controller: JSON response through Active Model Serializers
class Api::V1::CommentVotesController < ApiController
  respond_to :json

  # Render all Comment Votes using CommentVoteSerializer, and organize them by user_id
  def index
    render json: CommentVote.order('user_id ASC').all
  end

  # render specified CommentVote using CommentVoteSerializer.
  def show
    render json: commentVote
  end

  # Render the created CommentVote using CommentVoteSerializer and the AMS Deserialization..
  def create
    comment = Comment.find(comment_vote_params[:comment_id])
    if current_user == comment.user
      return render json: {}, status: :forbidden
    elsif CommentVote.where(:comment_id => comment, :user_id => current_user).exists?
      return render json: {}, status: :conflict
    else
      json_voting_create(comment, comment_vote_params, CommentVote)
    end
  end

  # Render the updated CommentVote using CommentSerializer and the AMS Deserialization.
  def update
    userVotedAlready = CommentVote.where(:comment_id => comment_vote_params[:comment_id], :user_id => comment_vote_params[:user_id]).exists?
    if userVotedAlready
      if commentVote.positive_vote != comment_vote_params[:positive_vote]
        comment = Comment.find(comment_vote_params[:comment_id])
        json_voting_update(comment, commentVote, comment_vote_params, CommentVote)
      else
        return render json: {}, status: :no_content
      end
    else
      return render json: {}, status: :unprocessable_entity
    end
  end

  # Destroy commentVote from the AMS Deserialization params.
  def destroy
      render json: {}, status: :method_not_allowed
  end

  private

  # CommentVote object from the Deserialization params.
  def commentVote
    CommentVote.find(params[:id])
  end

  # AMS Comment Deserialization.
  def comment_vote_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
