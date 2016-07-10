class Parent::SubjectsController < ApplicationController
  def index
    @following = Following.find params[:following_id]
    authorize @following, :show?

    @student = @following.student
    @classroom = @student.classroom

    if @classroom.present?
      @subjects = @classroom.school_class.subjects
    else
      flash.now.alert = 'No Classroom'
      render 'missing'
    end
  end
end
