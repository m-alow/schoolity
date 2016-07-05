class Parent::GradesController < ApplicationController
  # GET /parent/followings/1/grades
  def index
    @following = Following.find params[:following_id]
    authorize @following, :show?

    @student = @following.student
    @grades = grouped_grades
  end

  private

  def grouped_grades
    @student
      .grades
      .includes(exam: :subject)
      .sort_by { |g| g.exam.date }
      .reverse
      .group_by { |g| g.exam.subject }
  end
end
