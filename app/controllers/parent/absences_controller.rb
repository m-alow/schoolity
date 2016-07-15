class Parent::AbsencesController < ApplicationController
  def index
    following = Following.find params[:following_id]
    authorize following, :show?
    @student = following.student
    @absences = @student.absences.sorted
  end
end
