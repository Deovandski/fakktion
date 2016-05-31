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

  # Render the created InnerCommentVote using InnerCommentVoteSerializer and the AMS Deserialization.
  # Do not allow an user to vote multiple times on the same item!
  # positiveVote boolean vote change is propagated right before creating the vote.
  def create
    userVotedAlready = InnerCommentVote.where(:inner_comment_id => inner_comment_vote_params[:inner_comment_id], :user_id => inner_comment_vote_params[:user_id]).exists?
    innerComment = InnerComment.find(inner_comment_vote_params[:inner_comment_id])
    user = User.find(inner_comment_vote_params[:user_id])
    loggedUserIsAuthor = false
    if user.id == innerComment.user.id
      loggedUserIsAuthor = true
    end
    if userVotedAlready || loggedUserIsAuthor
      return render json: {}, status: :unprocessable_entity
    else
      if inner_comment_vote_params[:positive_vote]
        innerComment.increment(:empathy_level)
      else
        innerComment.decrement(:empathy_level)
      end
      innerComment.save
      json_create(inner_comment_vote_params, InnerCommentVote)
    end
  end

  # Render the updated InnerCommentVote using InnerCommentSerializer and the AMS Deserialization.
  # Only allow the user to change vote from +1 to -1 through positiveVote boolean.
  def update
    userVotedAlready = InnerCommentVote.where(:inner_comment_id => inner_comment_vote_params[:inner_comment_id], :user_id => inner_comment_vote_params[:user_id]).exists?
    if userVotedAlready
      if innerCommentVote.positive_vote != inner_comment_vote_params[:positive_vote]
        innerComment = InnerComment.find(inner_comment_vote_params[:inner_comment_id])
        # Negate previous vote from -1 to +1, and vice versa.
        if innerCommentVote.positive_vote
          innerComment.decrement(:empathy_level, 2)
        else
          innerComment.increment(:empathy_level, 2)
        end
        innerComment.save
        innerCommentVote.save
        json_update(innerCommentVote, inner_comment_vote_params)
      else
        return render json: {}, status: :ok
      end
    else
      return render json: {}, status: :unprocessable_entity
    end
  end

  # Destroy innerCommentVote from the AMS Deserialization params.
  def destroy
    # Do not allow to destroy a innerCommentVote.
    # json_destroy(innerCommentVote)
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
