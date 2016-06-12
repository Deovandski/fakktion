# Comment Votes Controller: JSON response through Active Model Serializers
class Api::V1::CommentVotesController < ApiController
  respond_to :json

  # Render all Comment Votes using CommentVoteSerializer, and organize them by user_id
  def index
    json_render_all(CommentVote, :user_id)
  end

  # render specified CommentVote using CommentVoteSerializer.
  def show
    render json: commentVote
  end

  # Render the created CommentVote using CommentVoteSerializer and the AMS Deserialization..
  def create
    userVotedAlready = CommentVote.where(:comment_id => comment_vote_params[:comment_id], :user_id => comment_vote_params[:user_id]).exists?
    comment = Comment.find(comment_vote_params[:comment_id])
    user = User.find(comment_vote_params[:user_id])
    loggedUserIsAuthor = false
    if user.id == comment.user.id
      loggedUserIsAuthor = true
    end
    if userVotedAlready || loggedUserIsAuthor
      return render json: {}, status: :unprocessable_entity
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
  
  # CommentVote object from the Deserialization params.
  def commentVote
    CommentVote.find(params[:id])
  end

  # AMS Comment Deserialization.
  def comment_vote_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
