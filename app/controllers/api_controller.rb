# Api Controller: Set options for all v1 API controllers. 
class ApiController < ActionController::Base
  prepend_before_filter :disable_devise_trackable

  protected
  # Disable Devise Trackable for all API requests
  # Devise Trackable still tracks login since Devise is hooked to ApplicationController.
  
  def json_create(resource_params)
    resource_obj = Genre.new(resource_params)
    if resource_obj.save
      return render json: resource_obj, status: :ok
    else
      return render json: resource_obj.errors, status: :unprocessable_entity
    end
  end
  
  def json_update(resource_obj,resource_params)
    if resource_obj.update(resource_params)
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
  def disable_devise_trackable
    request.env["devise.skip_trackable"] = true
  end
end
