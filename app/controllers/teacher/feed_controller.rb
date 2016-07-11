class Teacher::FeedController < ApplicationController
  include EnsureTeacher
  def index
  end
end
