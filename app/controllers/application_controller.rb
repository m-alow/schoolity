class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  protect_from_forgery with: :exception, :if => Proc.new { |c| c.request.format != 'application/json' }

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include ApplicationHelper

  private

  def user_not_authorized
    redirect_to user_root_url, alert: 'You are not authorized.'
  end
end
