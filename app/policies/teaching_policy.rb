class TeachingPolicy < ApplicationPolicy
  def index?
    rails unless record.is_a? Classroom
    user.admin? || user.owns?(record.school) || user.administrates?(record.school)
  end

  def show?
    user.admin? || user.owns?(school) || user.administrates?(school)
  end

  alias_method :new?, :show?
  alias_method :create?, :show?
  alias_method :edit?, :show?
  alias_method :update?, :show?
  alias_method :destroy?, :show?

  private

  def school
    record.classroom.school
  end
end
