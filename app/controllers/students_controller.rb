class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :set_school_from_params, only: [:index, :new, :create]

  # GET /schools/1/students
  def index
    StudentPolicy.new(current_user, @school).authorize_action(:index?)
    @students = @school.students
  end

  # GET /students/1
  def show
    authorize @student
  end

  # GET /schools/1/students/new
  def new
    @student = @school.students.build
    authorize @student
  end

  # GET /students/1/edit
  def edit
    authorize @student
  end

  # POST /schools/1/students
  def create
    @student = @school.students.build(student_params)
    authorize @student
    if @student.save
      redirect_to @student, notice: 'Student was successfully added.'
    else
      render :new
    end
  end

  # PATCH/PUT /students/1
  def update
    authorize @student
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    authorize @student
    @student.destroy
    redirect_to school_students_url(@school), notice: 'Student was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  def set_school
    @school = @student.school
  end

  def set_school_from_params
    @school = School.find(params[:school_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :father_name, :mother_name, :birthdate)
  end
end
