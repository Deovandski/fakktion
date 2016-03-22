# Sessions Controller: Devise Custom Session Controller.
class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super do |user|
      user.authentication_token = Devise.friendly_token
      user.save
      if request.format.json?
      data = {
        token: user.authentication_token,
        email: user.email,
        userId: user.id
      }
      render json: data, status: 201 and return
      end
    end
  end
end
