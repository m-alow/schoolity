class DayBehaviorPolicy < ApplicationPolicy
  def show?
    school = record.behaviorable.classroom.school
    user.owns?(school) ||
      user.administrates?(school) ||
      user.follows?(record.student)
  end

  def index?
    raise unless record.is_a? Day
    school = record.classroom.school
    user.owns?(school) ||
      user.administrates?(school)
  end

  alias_method :edit?, :index?

  def update?
    school = record.behaviorable.classroom.school
    user.owns?(school) ||
      user.administrates?(school)
  end
end
