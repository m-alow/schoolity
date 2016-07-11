class Teacher::FeedController < ApplicationController
  include EnsureTeacher

  def index
    @feed = current_user.teacher_feed
  end
end
