class Parent::FeedController < ApplicationController
  include EnsureParent

  def index
    @notifications = current_user.parent_notifications.paginate page: params[:page]
    @feed = current_user.parent_feed(@notifications)
  end
end
