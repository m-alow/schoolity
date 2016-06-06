class FollowingPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user.follows? record.student
  end

  def create?
    user
  end

  alias_method :new?, :create?
  alias_method :destroy?, :show?
end
