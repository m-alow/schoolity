class SchoolPolicy < ApplicationPolicy
  def activate?
    user.admin?
  end
end
