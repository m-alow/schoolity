class AbsencePolicy < ApplicationPolicy
  def index?
    raise unless record.is_a? Day
    school = record.classroom.school
    user.owns?(school) || user.administrates?(school)
  end

  def update?
    school = record.day.classroom.school
    user.owns?(school) || user.administrates?(school)
  end

  alias_method :destroy?, :update?
end
