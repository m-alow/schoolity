class GradePolicy < ApplicationPolicy
  def show?
    user.owns?(school) ||
      user.administrates?(school) ||
      user.teaches_subject_in_classroom?(record.exam.subject, record.exam.classroom) ||
      user.follows?(record.student)
  end


  def school
    record.exam.classroom.school
  end
end
