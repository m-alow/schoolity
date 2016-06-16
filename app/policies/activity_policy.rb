class ActivityPolicy < ApplicationPolicy
  def update?
    user.teaches_student_a_subject? record.student, record.lesson.subject
  end
end
