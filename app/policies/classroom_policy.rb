class ClassroomPolicy < ApplicationPolicy
  def index?
    reails unless record.is_a? School
    user.admin? || user.owns?(record) || user.administrates?(record)
  end

  def new?
    user.admin? || user.owns?(record.school) || user.administrates?(record.school)
  end

  alias_method :create?, :new?
  alias_method :edit?, :new?
  alias_method :update?, :new?
  alias_method :destroy?, :new?
  alias_method :show?, :new?
end
