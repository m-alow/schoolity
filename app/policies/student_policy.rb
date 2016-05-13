class StudentPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? School
    user.admin? || user.owns?(record) || user.administrates?(record)
  end

  def show?
    user.admin? || user.owns?(record.school) || user.administrates?(record.school)
  end

  def new?
    user.admin? || user.owns?(record.school) || user.administrates?(record.school)
  end

  alias_method :create?, :new?
  alias_method :edit?, :new?
  alias_method :update?, :new?
  alias_method :destroy?, :new?
end
