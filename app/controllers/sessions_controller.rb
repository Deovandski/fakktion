# Sessions Controller: Devise Custom Session Controller.
class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_filter :verify_authenticity_token, only: [:destroy]
  
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
  
  def destroy
    #signed_out_user = current_user
    sign_out :user
    session.try(:delete, :_csrf_token)
    # Prevent Token Fixation attacks by generating a new token upon user logout.
    #signed_out_user.authentication_token = Devise.friendly_token
    #signed_out_user.save
    super
  end
end
