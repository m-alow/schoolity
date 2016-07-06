class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]
  before_action :set_classroom_from_params, only: [:index, :new, :create]

  # GET /classrooms/1/exams
  def index
    ExamPolicy.new(current_user, @classroom).authorize_action(:index?)
    @exams = @classroom.exams
  end

  # GET /exams/1
  def show
    authorize @exam
  end

  # GET /classrooms/1/exams/new
  def new
    @exam = @classroom.exams.build
    authorize @exam

    @classroom.students.each { |student| @exam.grades.build student: student }
  end

  # GET /exams/1/edit
  def edit
    authorize @exam
  end

  # POST /classrooms/1/exams
  def create
    @exam = @classroom.exams.build(create_exam_params)
    authorize @exam

    params[:exam][:grades_attributes].each do |_, grade|
      student = @classroom.students.find grade[:student_id]
      @exam.grades << Grade.new(exam: @exam, score: grade[:score], student: student)
    end

    if @exam.save
      @exam.grades.each do |g|
        Notifier::Create
          .new(Scope::Student::Followers.new g.student)
          .call(g)
      end

      redirect_to @exam, notice: 'Exam was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /exams/1
  def update
    authorize @exam

    @exam.attributes = update_exam_params
    params[:exam][:grades_attributes].each do |_, grade|
      student = @classroom.students.find grade[:student_id]
      @exam.grades.detect { |g| g.student_id == student.id }.score =  grade[:score]
    end

    if @exam.save
      redirect_to @exam, notice: 'Exam was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /exams/1
  def destroy
    authorize @exam

    @exam.destroy
    redirect_to classroom_exams_url(@classroom), notice: 'Exam was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    def set_classroom
      @classroom = @exam.classroom
    end

    def set_classroom_from_params
      @classroom = Classroom.find(params[:classroom_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_exam_params
      params.require(:exam).permit(:subject_id, :score, :minimum_score, :date, :description)
    end

    def update_exam_params
      params.require(:exam).permit(:score, :minimum_score, :date, :description)
    end
end
