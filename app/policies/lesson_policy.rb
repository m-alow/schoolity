class LessonPolicy < ApplicationPolicy
  def update?
    user.teaches_subject_in_classroom? record.subject, record.day.classroom
  end

  alias_method :update_qualified?, :update?
end
