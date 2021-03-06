class ActivityPolicy < ApplicationPolicy
  def show?
    user.owns?(record.student.school) ||
      user.administrates?(record.student.school) ||
      user.teaches_subject_in_classroom?(record.lesson.subject, record.lesson.day.classroom) ||
      user.follows?(record.student)
  end

  def update?
    user.teaches_student_a_subject? record.student, record.lesson.subject
  end

  def index?
    raise unless record.is_a? Lesson
    classroom = record.day.classroom
    user.owns?(classroom.school) || user.administrates?(classroom.school) || user.teaches_subject_in_classroom?(record.subject, classroom)
  end

  def edit?
    raise unless record.is_a? Lesson
    user.teaches_subject_in_classroom?(record.subject, record.day.classroom)
  end
end
