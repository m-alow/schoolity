class LessonPolicy < ApplicationPolicy
  def update?
    user.teaches_subject_in_classroom? record.subject, classroom
  end

  def show?
    user.owns?(classroom.school) ||
      user.administrates?(classroom.school) ||
      user.teaches_subject_in_classroom?(record.subject, classroom) ||
      user.follows_student_in_classroom?(classroom)
  end

  alias_method :update_qualified?, :update?

  private

  def classroom
    record.day.classroom
  end
end
