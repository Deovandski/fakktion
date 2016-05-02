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

  # Render the created CommentVote using CommentVoteSerializer and the AMS Deserialization.
  # Do not allow an user to vote multiple times on the same item!
  # positiveVote boolean vote change is propagated right before creating the vote.
  def create
    userVotedAlready = CommentVote.where(:comment_id => comment_vote_params[:comment_id], :user_id => comment_vote_params[:user_id]).exists?
    if userVotedAlready
      return render json: {}, status: :unprocessable_entity
    else
      comment = Comment.find(comment_vote_params[:comment_id])
      if comment_vote_params[:positive_vote]
        comment.increment(:empathy_level)
      else
        comment.decrement(:empathy_level)
      end
      comment.save
      json_create(comment_vote_params, CommentVote)
    end
  end

  # Render the updated CommentVote using GenreSerializer and the AMS Deserialization.
  # Only allow the user to change vote from +1 to -1 through positiveVote boolean.
  def update
    userVotedAlready = CommentVote.where(:comment_id => comment_vote_params[:comment_id], :user_id => comment_vote_params[:user_id]).exists?
    if userVotedAlready
      if commentVote.positive_vote != comment_vote_params[:positive_vote]
        comment = Comment.find(comment_vote_params[:comment_id])
        # Negate previous vote from -1 to +1, and vice versa.
        if commentVote.positive_vote
          comment.decrement(:empathy_level, 2)
        else
          comment.increment(:empathy_level, 2)
        end
        commentVote.save
        json_update(commentVote, comment_vote_params)
      else
        return render json: {}, status: :ok
      end
    else
      return render json: {}, status: :unprocessable_entity
    end
  end

  # Destroy commentVote from the AMS Deserialization params.
  def destroy
    # Do not allow to destroy a commentVote.
    # json_destroy(commentVote)
  end

  private

  # CommentVote object from the Deserialization params.
  # This object always will look for the Comment vote by the logged in user on the frontend.
  def commentVote
    CommentVote.find(params[:id])
  end

  # AMS Genre Deserialization.
  def comment_vote_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
