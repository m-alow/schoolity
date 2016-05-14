class SubjectPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? SchoolClass
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
    record.school_class.school
  end
end
