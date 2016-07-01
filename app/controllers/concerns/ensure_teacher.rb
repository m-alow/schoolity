module EnsureTeacher
  extend ActiveSupport::Concern

  included do
    before_action :ensure_teacher
  end

  def ensure_teacher
    unless current_user.teacher?
      flash.now.notice = 'You are not a teacher.'
      render 'shared/non_teacher'
    end
  end
end
