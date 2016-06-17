class ExamPolicy < ApplicationPolicy
  def index?
    user.owns?(record.school) || user.administrates?(record.school) || user.teaches_in_classroom?(record)
  end

  def show?
    classroom = record.classroom
    school = classroom.school
    user.owns?(school) || user.administrates?(school) || user.teaches_subject_in_classroom?(record.subject, classroom) || user.follows_student_in_classroom?(classroom)
  end

  def new?
    user.teaches_in_classroom? record.classroom
  end

  def create?
    user.teaches_subject_in_classroom? record.subject, record.classroom
  end

  alias_method :edit?, :create?
  alias_method :update?, :create?
  alias_method :destroy?, :create?
end
