# Comment Votes Controller: JSON response through Active Model Serializers
class Api::V1::InnerCommentVotesController < ApiController
  respond_to :json

  # Render all Inner Comment Votes using InnerCommentVoteSerializer, and organize them by user_id
  def index
    json_render_all(InnerCommentVote, :user_id)
  end

  # render specified innerCommentVote using InnerCommentVoteSerializer.
  def show
    render json: innerCommentVote
  end

  # Render the created CommentVote using CommentVoteSerializer and the AMS Deserialization.
  def create
    innerComment = InnerComment.find(inner_comment_vote_params[:inner_comment_id])
    if current_user == innerComment.user
      return render json: {}, status: :forbidden
    elsif InnerCommentVote.where(:inner_comment_id => innerComment, :user_id => current_user).exists?
      return render json: {}, status: :conflict
    else
      json_voting_create(innerComment, inner_comment_vote_params, InnerCommentVote)
    end
  end

  # Render the updated CommentVote using CommentSerializer and the AMS Deserialization.
  def update
    userVotedAlready = InnerCommentVote.where(:inner_comment_id => inner_comment_vote_params[:inner_comment_id], :user_id => inner_comment_vote_params[:user_id]).exists?
    if userVotedAlready
      if innerCommentVote.positive_vote != inner_comment_vote_params[:positive_vote]
        innerComment = InnerComment.find(inner_comment_vote_params[:inner_comment_id])
        json_voting_update(innerComment, innerCommentVote, inner_comment_vote_params, InnerCommentVote)
      else
        return render json: {}, status: :no_content
      end
    else
      return render json: {}, status: :unprocessable_entity
    end
  end

  # Destroy innerCommentVote from the AMS Deserialization params.
  def destroy
      render json: {}, status: :method_not_allowed
  end

  private

  # innerCommentVote object from the Deserialization params.
  def innerCommentVote
    InnerCommentVote.find(params[:id])
  end

  # AMS InnerCommentVote Deserialization.
  def inner_comment_vote_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
