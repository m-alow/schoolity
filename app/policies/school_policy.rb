class SchoolPolicy < ApplicationPolicy
  alias_method :school, :record

  def index?
    true
  end

  def show?
    school.active? || user.admin? || school_owner?
  end

  def new?
    user
  end

  def edit?
    user.admin? || school_owner?
  end

  def create?
    true
  end

  def update?
    user.admin? || school_owner?
  end

  def destroy?
    user.admin? || school_owner?
  end

  def activate?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where("active = 't' or user_id = ?", user)
      end
    end
  end

  private

  def school_owner?
    user == school.owner
  end
end
