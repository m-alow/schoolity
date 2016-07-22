class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user_from_token!, only: [:create]

  def create
    user = User.find_by(email: params[:user][:email])
    if user.present? && user.valid_password?(params[:user][:password])
      user.update(authentication_token: nil) if user.authentication_token.nil?
      render json: user, status: :ok
    else
      render json: { errors: ['Invalid email an password combination.'] }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.update(authentication_token: nil)
    respond_to do |format|
      format.json { render json: 'signed out', status: :ok }
    end
  end
end
