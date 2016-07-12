class Parent::ActivitiesController < ApplicationController
  def index
    following = Following.find params[:following_id]
    authorize following, :show?
    @student = following.student
    @activities = @student.activities.sorted
  end
end
