class FollowingCodePolicy < ApplicationPolicy
  def index?
    user.admin? || user.owns?(record) || user.administrates?(record)
  end

  def create?
    user.admin? || user.owns?(school) || user.administrates?(school)
  end

  alias_method :show?, :create?
  alias_method :destroy?, :create?

  private

  def school
    record.student.school
  end
end
