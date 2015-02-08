class SessionsController < ApplicationController
  def create
    user = User.find_by_email(user_params[:email])
    ap user

    if user && user.authenticate(user_params[:password])
      session[:current_user_id] = user.id
      redirect_to profile_path
    else
      redirect_to new_session_path, alert: "Password or email are incorrect, please try again."
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end

private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
