class SchoolClassPolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? School
    user.admin? || record.owner == user or record.administrated_by?(user)
  end

  def show?
    user.admin? or record.school.owner == user or record.school.administrated_by?(user)
  end

  def new?
    return false unless record.school.try(:active?)
    user.admin? or record.school.owner == user or record.school.administrated_by?(user)
  end

  alias_method :create?, :new?
  alias_method :edit?, :new?
  alias_method :update?, :new?
  alias_method :destroy?, :new?
end
