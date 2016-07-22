module EnsureAdmin
  extend ActiveSupport::Concern

  included do
    before_action :ensure_admin
  end

  def ensure_admin
    unless current_user.admin? || current_user.school_admin?
      flash.now.notice = 'You are not an admin.'
      render 'shared/non_admin'
    end
  end
end
