# Sessions Controller: Devise Custom Session Controller.
class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_filter :verify_authenticity_token, only: [:destroy]
  
  def create
    super do |user|
      # Generate and save a fresh token for 200 sign_in 
      user.authentication_token = Devise.friendly_token
      user.save
      if request.format.json?
      data = {
        token: user.authentication_token,
        email: user.email,
        userId: user.id
      }
      render json: data, status: 200 and return
      end
    end
  end
  
  def destroy
    sign_out :user
    session.try(:delete, :_csrf_token)
    super
  end
end
