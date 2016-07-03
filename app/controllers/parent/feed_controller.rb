class Parent::FeedController < ApplicationController
  include EnsureParent

  def index
    @feed = current_user.parent_feed
  end
end
