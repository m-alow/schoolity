class StudyingsController < ApplicationController
  before_action :set_studying, only: [:show, :edit, :update, :destroy]
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_student_from_params, only: [:index, :new, :create]
  after_action :verify_authorized, except: :index

  # GET /students/1/studyings
  def index
    StudyingPolicy.new(current_user, @student.school).authorize_action(:index?)
    @studyings = @student.studyings
  end

  # GET /studyings/1
  def show
    authorize @studying
  end

  # GET /students/1/studyings/new
  def new
    @studying = @student.studyings.build
    authorize @studying
  end

  # GET /students/1/studyings/1/edit
  def edit
    authorize @studying
  end

  # POST /students/1/studyings
  def create
    @studying = @student.studyings.build(studying_params)
    authorize @studying

    if @studying.save
      redirect_to @studying, notice: 'Studying was successfully added.'
    else
      render :new
    end
  end

  # PATCH/PUT /studyings/1
  def update
    authorize @studying
    if @studying.update(studying_params)
      redirect_to @studying, notice: 'Studying was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /studyings/1
  def destroy
    authorize @studying
    @studying.destroy
    redirect_to student_studyings_url(@student), notice: 'Studying was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_studying
    @studying = Studying.find(params[:id])
  end

  def set_student
    @student = @studying.student
  end

  def set_student_from_params
    @student = Student.find(params[:student_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def studying_params
    params.require(:studying).permit(:classroom_id, :beginning_date, :end_date)
  end
end
