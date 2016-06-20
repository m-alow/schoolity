class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user_from_token!, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      warden.custom_failure!
      render json: { errors: user.errors }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
