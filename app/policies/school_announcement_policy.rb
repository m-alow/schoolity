class SchoolAnnouncementPolicy < ApplicationPolicy
  def index?
  user.owns?(record) ||
      user.administrates?(record) ||
      user.teaches_in_school?(record) ||
      user.follows_student_in_school?(record)
  end

  def show?
    user.owns?(school) ||
      user.administrates?(school) ||
      user.teaches_in_school?(school) ||
      user.follows_student_in_school?(school)
  end

  def new?
    user.owns?(school) || user.administrates?(school)
  end

  def edit?
    user.authors?(record) &&
      (user.owns?(school) || user.administrates?(school))
  end

  alias_method :create?, :new?

  alias_method :update?, :edit?
  alias_method :destroy?, :edit?

  private

  def school
    record.announceable
  end
end
