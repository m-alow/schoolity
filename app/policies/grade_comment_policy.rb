class GradeCommentPolicy < ApplicationPolicy
  def create?
    user.owns?(school) ||
      user.administrates?(school) ||
      user.teaches_subject_in_classroom?(grade.exam.subject, grade.exam.classroom) ||
      user.follows?(grade.student)
  end

  private

  def grade
    record.commentable
  end

  def school
    grade.exam.classroom.school
  end
end
