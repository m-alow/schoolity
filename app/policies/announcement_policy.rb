class AnnouncementPolicy < ApplicationPolicy
  def delegate_policy
    (record.announceable_type + 'AnnouncementPolicy')
      .constantize
      .new(user, record)
      .send(__callee__)
  end

  alias_method :show?, :delegate_policy
  alias_method :new?, :delegate_policy
  alias_method :edit?, :delegate_policy
  alias_method :create?, :delegate_policy
  alias_method :update?, :delegate_policy
  alias_method :destroy?, :delegate_policy
end
