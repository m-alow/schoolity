class BehaviorPolicy < ApplicationPolicy
  def delegate_policy
    (record.behaviorable_type + 'BehaviorPolicy')
      .constantize
      .new(user, record)
      .send(__callee__)
  end

  alias_method :show?, :delegate_policy
end
