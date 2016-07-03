module EnsureParent
  extend ActiveSupport::Concern

  included do
    before_action :ensure_parent
  end

  def ensure_parent
    unless current_user.parent?
      flash.now.notice = 'You are not a parent.'
      render 'shared/non_parent'
    end
  end
end
