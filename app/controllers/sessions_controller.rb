# Sessions Controller: Devise Custom Session Controller.
class SessionsController < Devise::SessionsController
  respond_to :json

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
  
  # 422 CSRF token issue when frontend does not reload page before logging out
  def destroy
    super do |user|
      render json: {}, status: 204 and return
    end
  end
end
