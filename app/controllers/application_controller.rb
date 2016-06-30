class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  protect_from_forgery with: :exception, :if => Proc.new { |c| c.request.format != 'application/json' }

  acts_as_token_authentication_handler_for User, fallback: false, :if => Proc.new { |c| c.request.format == 'application/json' }

  before_action :authenticate_user!
  before_action :authenticate_user_from_token!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include ApplicationHelper

  private

  def user_not_authorized
    redirect_to user_root_url, alert: 'You are not authorized.'
  end

  def authenticate_user_from_token!
    if request.format.json?
      user_email = request.headers['X-User-Email']
      user_token = request.headers['X-User-Token']
      user = User.find_by(email: user_email)
      if user.present? && Devise.secure_compare(user.authentication_token, user_token)
        return true
      else
        render json: { errors: ['Invalid email and token combination.'] }, status: :unauthorized
      end
    end
  end
end
