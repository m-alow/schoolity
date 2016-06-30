class Api::V1::ApiController < ActionController::Base
  include Pundit

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  acts_as_token_authentication_handler_for User

  before_action :authenticate_user_from_token!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { errors: ['You are not authorized.'] }, status: :forbidden
  end

  def record_not_found
    render json: { errors: ['Not found.'] }, status: :not_found
  end

  def authenticate_user_from_token!
    user_email = request.headers['X-User-Email']
    user_token = request.headers['X-User-Token']
    user = User.find_by(email: user_email)
    if user.present? && Devise.secure_compare(user.authentication_token, user_token)
      return true
    else
      render json: { errors: ['Invalid email and token combination.'] }, status: :unauthorized
    end
  end

  def current_user
    User.find_by email: request.headers['X-User-Email']
  end
end
