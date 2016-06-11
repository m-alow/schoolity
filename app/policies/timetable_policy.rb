class TimetablePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    raise unless record.is_a? Classroom
    user.owns?(record.school) || user.administrates?(record.school)
  end

  def show?
    user.owns?(school) || user.administrates?(school) || user.follows_student_in_classroom?(record.classroom)
  end

  def new?
    user.owns?(school) || user.administrates?(school)
  end

  alias_method :current?, :show?

  alias_method :init?, :new?
  alias_method :create?, :new?
  alias_method :destroy?, :new?
  alias_method :edit?, :new?
  alias_method :update?, :new?

  private

  def school
    record.classroom.school
  end
end
