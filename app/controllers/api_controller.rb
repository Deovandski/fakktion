# Api Controller: Set options for all v1 API controllers. 
class ApiController < ApplicationController
  prepend_before_filter :disable_devise_trackable

  # Shared JSON API render methods.
  protected
  def json_render_all(resource_model, _sortParam)
      return render json: resource_model.all.sort_by{|x| x[:sortParam]}
  end
  
  def json_create(resource_params, resource_model)
    routine_check
    resource_obj = resource_model.new(resource_params)
    puts current_user.reputation
    # Only allow resource creation if the user reputation is in good standing depending on the Level ban. See Fakktion Issue #17
    if resource_model == FactType || resource_model == InnerComment || resource_model == Genre || resource_model == Topic || resource_model == Category
      if current_user.reputation < -100
        return render json: {}, status: :forbidden
      else
        return create_resource(resource_obj)
      end
    elsif resource_model == CommentVote || resource_model == InnerCommentVote
      if current_user.reputation < -200
        return render json: {}, status: :forbidden
      else
        return create_resource(resource_obj)
      end
    end
  end
  
  # XSS prevention used on Post, Comment and Inner Comment.
  def json_create_and_sanitize(resource_params, resource_model)
    routine_check
    resource_obj = resource_model.new(resource_params)
    resource_obj.text = protect_from_xss_like_a_boss(resource_obj.text)
    if resource_model == Post
      if current_user.reputation < -250
        return render json: {}, status: :forbidden
      else
        return create_resource(resource_obj)
      end
    elsif resource_model == Comment
      if current_user.reputation < -500
        return render json: {}, status: :forbidden
      else
        return create_resource(resource_obj)
      end
    end
  end
  
  def json_update(resource_obj,resource_params, resource_model)
    if routine_check
      if resource_model == FactType || resource_model == InnerComment || resource_model == Genre || resource_model == Topic || resource_model == Category
        if current_user.reputation < -100
          return render json: {}, status: :forbidden
        else
          return update_resource(resource_obj,resource_params)
        end
      end
    end
  end
  
  # Create Votes.
  def json_voting_create(commenting_obj, resource_params, resource_model)
    routine_check
    if resource_model == CommentVote || resource_model == InnerCommentVote
      if current_user.reputation < -200
        return render json: {}, status: :forbidden
      else
        commenting_vote_obj = resource_model.new(resource_params)
        votingHandler(commenting_obj, commenting_vote_obj, false)
        return render json: commenting_vote_obj, status: :ok
      end
    end
  end
  
  # Update Existing Votes
  def json_voting_update(commenting_obj,commenting_vote_obj, resource_params, resource_model)
    if routine_check
      if resource_model == CommentVote || resource_model == InnerCommentVote
        if current_user.reputation < -200
          return render json: {}, status: :forbidden
        else
          commenting_vote_obj.update(resource_params.except(:voting_record))
          votingHandler(commenting_obj, commenting_vote_obj, true)
          return render json: commenting_vote_obj, status: :ok
        end
      end
      else
        return render json: {}, status: :unprocessable_entity
    end
  end
  
  
  # Voting Amount Control Method
  def votingHandler(commenting_obj, commenting_vote_obj , reverseVote)
    # Reverse voting acts upon the recorded vote enacted early on.
    if reverseVote
      reverseVotingAmmount = commenting_vote_obj.recorded_vote * 2
      if commenting_vote_obj.positive_vote
        commenting_obj.increment(:empathy_level, reverseVotingAmmount)
        commenting_obj.user.increment(:reputation, reverseVotingAmmount)
      else
        commenting_obj.decrement(:empathy_level, reverseVotingAmmount)
        commenting_obj.user.decrement(:reputation, reverseVotingAmmount)
      end
    else
      # Get the amount of votes that the user can cast.
      if isLegend
        votingAmmount = 4
      elsif isUserAdmin
        votingAmmount = 3
      elsif isSuperUser
        votingAmmount = 2
      else
        votingAmmount = 1
      end
      commenting_vote_obj.recorded_vote = votingAmmount
      if commenting_vote_obj.positive_vote
        commenting_obj.increment(:empathy_level, votingAmmount)
        commenting_obj.user.increment(:reputation, votingAmmount)
      else
        commenting_obj.decrement(:empathy_level, votingAmmount)
        commenting_obj.user.decrement(:reputation, votingAmmount)
      end
    end
      commenting_obj.save
      commenting_obj.user.save
      commenting_vote_obj.save
  end
  
  # Update Method used by Post and Comment. User must be signed for all Patch operations
  # Except for updating the views_counter of a given post.
  def json_update_and_sanitize(resource_obj,resource_params, resource_model)
    if routine_check
      resource_obj.text = protect_from_xss_like_a_boss(resource_params[:text])
      if resource_model == Post
        if current_user.reputation < -250
          return render json: {}, status: :forbidden
        else
          return update_resource(resource_obj, resource_params.except(:text))
        end
      elsif resource_model == Comment
        if current_user.reputation < -500
          return render json: {}, status: :forbidden
        else
          return update_resource(resource_obj, resource_params.except(:text))
        end
      end
    else
      if resource_model == Post
        return update_resource(resource_obj,resource_params.except(:title,:text,:genre_id,:topic_id,:category_id,:user_id,:comments_count,:fact_link,:fiction_link))
      else
        return render json: {}, status: :forbidden
      end
    end
  end
  
  def json_destroy(resource_obj)
    if !user_signed_in?
      return render json: {}, status: :forbidden
    end
    if resource_obj.destroy
      return render json: {}, status: :no_content
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end
  
  
  #Routine check for Reputation and Authorization
  def routine_check
    if !user_signed_in?
      return false
    else
      reputationCheck
      return true
    end
  end
  
  # Super User check alongside reputation check.
  def isSuperUser
    reputationCheck()
    return current_user.is_super_user
  end
  
  # Admin check alongside reputation check.
  def isUserAdmin
    reputationCheck()
    return current_user.is_admin
  end
    
  # Legend check alongside reputation check.
  def isLegend
    reputationCheck()
    return current_user.is_legend
  end
  
  private
    
  
  # Handle resource creation. 
  def create_resource(resource_obj)
    if resource_obj.save
      return render json: resource_obj, status: :ok
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end
  
  # Handles Updating a resource
  def update_resource(resource_obj, resource_params)
    if resource_obj.update(resource_params)
      return render json: resource_obj, status: :ok
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end
  
  # Validates the current_user reputation by using the live reputation score.
  def reputationCheck
    if current_user.reputation >= 500 && current_user.is_super_user == false
      current_user.is_super_user = true
      current_user.save()
    elsif current_user.reputation >= 1500 && current_user.is_admin == false
      current_user.is_admin = true
      current_user.save()
    elsif current_user.reputation >= 3000 && current_user.is_legend == false
      current_user.is_legend = true
      current_user.save()
    elsif current_user.reputation <= 500 && current_user.is_super_user == true
      current_user.is_super_user = true
      current_user.save()
    elsif current_user.reputation <= 1500 && current_user.is_admin == true
      current_user.is_admin = true
      current_user.save()
    elsif current_user.reputation <= 3000 && current_user.is_legend == true
      current_user.is_legend = true
      current_user.save()
    end
  end
  
  # Disable Devise Trackable for all API requests
  # Devise Trackable still tracks login since Devise is hooked to ApplicationController.
  def disable_devise_trackable
    request.env["devise.skip_trackable"] = true
  end
  
    # Prevent XSS Attacks like a boss!
  def protect_from_xss_like_a_boss(dirtyText)
    scrubber = Rails::Html::PermitScrubber.new
    scrubber.tags = ['a','p','br','b','i','s','ol','ul','li','h5','label']
    cleanText = Loofah.fragment(dirtyText).scrub!(scrubber)
    return cleanText.to_s
  end
end
