class CommentPolicy < ApplicationPolicy
  def delegate_policy
    (record.commentable_type + 'CommentPolicy')
      .constantize
      .new(user, record)
      .send(__callee__)
  end

  def destroy?
    user == record.user
  end

  alias_method :update?, :destroy?
  alias_method :create?, :delegate_policy
end
