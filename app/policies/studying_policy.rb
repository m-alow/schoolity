class StudyingPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? School
    user.admin? || user.owns?(record) || user.administrates?(record)
  end

  def show?
    user.admin? || school&.owned_by?(user) || user.administrates?(school)
  end

  alias_method :new?, :show?
  alias_method :create?, :show?
  alias_method :edit?, :show?
  alias_method :update?, :show?
  alias_method :destroy?, :show?

  private

  def school
    record.student.school
  end
end
