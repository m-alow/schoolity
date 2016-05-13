class Classrooms::StudentsController < ApplicationController
  before_action :set_classroom_and_school

  def index
    StudentPolicy.new(current_user, @school).authorize_action(:index?)
    @students = @classroom.students
  end

  def new
    @student = @school.students.build
    authorize @student
  end

  def create
    @student = @school.students.build(student_params)
    authorize @student
    beginning_date = params[:beginning_date]
    @student.studyings.build(
      classroom: @classroom,
      beginning_date: Date.new(beginning_date[:year].to_i, beginning_date[:month].to_i, beginning_date[:day].to_i))

    if @student.save
      redirect_to @student, notice: 'Student was successfully added.'
    else
      render :new
    end
  end

  private

  def set_classroom_and_school
    @classroom = Classroom.find(params[:classroom_id])
    @school = @classroom.school
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :father_name, :mother_name, :birthdate)
  end
end
