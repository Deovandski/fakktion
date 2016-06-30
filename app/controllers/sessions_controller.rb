# Sessions Controller: Devise Custom Session Controller.
class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_filter :verify_authenticity_token, only: [:destroy]
  
  # Customized Create action. super do |user| kicks in Devise followed by
  # returning JSON only for 200.
  def create
    super do |user|
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
  
  # Fully customized Destroy action in order to destroy the session on the server.
  # Destroy request on client is handled by 
  def destroy
    signed_out_user = current_user
    sign_out :user
    session.try(:delete, :_csrf_token)
    # Prevent Token Fixation attacks by generating a new token upon user logout.
    signed_out_user.authentication_token = Devise.friendly_token
    signed_out_user.save
    super
  end
end
