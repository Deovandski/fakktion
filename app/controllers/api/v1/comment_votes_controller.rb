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
    routine_check
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
      if comment_vote_params[:positive_vote]
        comment.increment(:empathy_level)
      else
        comment.decrement(:empathy_level)
      end
      comment.save
      json_create(comment_vote_params, CommentVote)
    end
  end

  # Render the updated CommentVote using CommentSerializer and the AMS Deserialization.
  # Only allow the user to change vote from +1 to -1 through positiveVote boolean.
  def update
    routine_check
    userVotedAlready = CommentVote.where(:comment_id => comment_vote_params[:comment_id], :user_id => comment_vote_params[:user_id]).exists?
    if userVotedAlready
      if commentVote.positive_vote != comment_vote_params[:positive_vote]
        comment = Comment.find(comment_vote_params[:comment_id])
        votingHandler(comment, yes, commentVote.positive_vote)
        comment.save
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
      render json: {}, status: :method_not_allowed
  end

  private

  def votingHandler(comment, reverseVote, isVotePositive)
    if isSuperUser
      votingAmmount = 2
    elsif isUserAdmin
      votingAmmount = 3
    elsif isLegend
      votingAmmount = 4
    else
      votingAmmount = 1
    end
    
    if reverseVote
      votingAmmount = votingAmmount * 2
      if isVotePositive
        comment.decrement(:empathy_level, votingAmmount)
      else
        comment.increment(:empathy_level, votingAmmount)
      end
    else
      if isVotePositive
        comment.increment(:empathy_level, votingAmmount)
      else
        comment.decrement(:empathy_level, votingAmmount)
      end
    end
    
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
