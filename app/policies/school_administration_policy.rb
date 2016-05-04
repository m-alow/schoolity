class SchoolAdministrationPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? School
    user.owns?(record) || user.admin?
  end

  def show?
    user.owns?(record.administrated_school) || user.admin?
  end

  alias_method :new?, :show?
  alias_method :create?, :show?
  alias_method :edit?, :show?
  alias_method :update?, :show?
  alias_method :destroy?, :show?
end
