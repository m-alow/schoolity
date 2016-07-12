class Parent::BehaviorsController < ApplicationController
  def index
    following = Following.find params[:following_id]
    authorize following, :show?
    @student = following.student
    @behaviors = @student.behaviors.sorted
  end
end
