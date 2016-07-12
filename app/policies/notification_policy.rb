class NotificationPolicy < ApplicationPolicy
  def show?
    user == record.recipient
  end
end
