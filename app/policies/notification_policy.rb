class NotificationPolicy < ApplicationPolicy
  def show?
    user == record.recipient
  end

  alias_method :update?, :show?
end
