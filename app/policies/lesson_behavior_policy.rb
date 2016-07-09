class LessonBehaviorPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? Lesson
    classroom = record.day.classroom
    school = classroom.school
    user.owns?(school) ||
      user.administrates?(school) ||
      user.teaches_subject_in_classroom?(record.subject, classroom)
  end

  def edit?
    raise unless record.is_a? Lesson
    user.teaches_subject_in_classroom?(record.subject, record.day.classroom)
  end

  def update?
    user.teaches_subject_in_classroom?(record.behaviorable.subject, record.behaviorable.day.classroom)
  end
end
