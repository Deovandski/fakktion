# Comment Votes Controller: JSON response through Active Model Serializers
class Api::V1::CommentVotesController < ApiController
  respond_to :json

  # Render all Comment Votes using CommentVoteSerializer, and organize them by user_id
  def index
    json_render_all(CommentVote, :user_id)
  end

  # render specified CommentVote using CommentVoteSerializer.
  # It is not a standard SHOW! See CommentVote.
  def show
    render json: CommentVote
  end

  # Render the created CommentVote using CommentVoteSerializer and the AMS Deserialization.
  # Do not allow an user to vote multiple times on the same item!
  # positiveVote boolean vote change is propagated right before creating the vote.
  def create
    if CommentVote.where(:comment_id => params[:comment_id], :user_id => params[:user_id]).exists?
      return render json: {}, status: :unprocessable_entity
    else
      comment = Comment.find(:comment_id)
      if params[:positive_vote]
        comment.increment_counter(:eligibility_counter)
      else
        comment.decrement_counter(:eligibility_counter)
      end
      comment.save
      json_create(comment_vote_params, CommentVote)
    end
  end

  # Render the updated CommentVote using GenreSerializer and the AMS Deserialization.
  # Only allow the user to change vote from +1 to -1 through positiveVote boolean.
  def update
    if commentVote.exists?
      if commentVote.positive_vote != params[:positive_vote]
        comment = Comment.find(:comment_id)
        # Negate previous vote from -1 to +1, and vice versa.
        if comment.positive_vote
          comment.decrement_counter(:eligibility_counter, 2)
        else
          comment.increment_counter(:eligibility_counter, 2)
        end
        comment.save
        json_update(comment_vote_params, CommentVote)
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
    CommentVote.where(:comment_id => params[:comment_id], :user_id => params[:user_id])
  end

  # AMS Genre Deserialization.
  def comment_vote_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
