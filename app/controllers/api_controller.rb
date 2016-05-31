# Api Controller: Set options for all v1 API controllers. 
class ApiController < ApplicationController
  prepend_before_filter :disable_devise_trackable

  # Shared JSON API render methods.
  protected
  def json_render_all(resource_model, sortParam)
      return render json: resource_model.all.sort_by{|x| x[:sortParam]}
  end
  def json_create(resource_params, resource_model)
    #puts current_user.id
    #puts current_user.reputation
    resource_obj = resource_model.new(resource_params)
    if resource_obj.save
      return render json: resource_obj, status: :ok
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end
  def json_create_and_sanitize(resource_params, resource_model)
    resource_obj = resource_model.new(resource_params)
    resource_obj.text = protect_from_xss_like_a_boss(resource_obj.text)
    if resource_obj.save
      return render json: resource_obj, status: :ok
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end  
  def json_update(resource_obj,resource_params)
    puts user_signed_in?
    puts current_user
    if resource_obj.update(resource_params)
      return render json: resource_obj, status: :ok
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end
  def json_update_and_sanitize(resource_obj,resource_params)
    resource_obj.text = protect_from_xss_like_a_boss(resource_params[:text])
    if resource_obj.update(resource_params.except(:text))
      return render json: resource_obj, status: :ok
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end
  def json_destroy(resource_obj)
    if resource_obj.destroy
      return render json: {}, status: :no_content
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  # Disable Devise Trackable for all API requests
  # Devise Trackable still tracks login since Devise is hooked to ApplicationController.
  def disable_devise_trackable
    request.env["devise.skip_trackable"] = true
  end
  
    # Prevent XSS Attacks like a boss!
  def protect_from_xss_like_a_boss(dirtyText)
    scrubber = Rails::Html::PermitScrubber.new
    scrubber.tags = ['a','p','br', 'strong', 'h4','h5']
    cleanText = Loofah.fragment(dirtyText).scrub!(scrubber)
    return cleanText.to_s
  end
end
