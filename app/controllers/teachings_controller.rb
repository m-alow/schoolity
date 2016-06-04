class TeachingsController < ApplicationController
  before_action :set_teaching, only: [:show, :edit, :update, :destroy]
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]
  before_action :set_classroom_from_params, only: [:index, :new, :create]
  after_action :verify_authorized, except: :index

  # GET /classrooms/1/teachings
  def index
    TeachingPolicy.new(current_user, @classroom).authorize_action(:index?)
    @teachings = @classroom.teachings
  end

  # GET /teachings/1
  def show
    authorize @teaching
  end

  # GET /classrooms/1/teachings/new
  def new
    @teaching = @classroom.teachings.build
    authorize @teaching
  end

  # GET /teachings/1/edit
  def edit
    authorize @teaching
  end

  # POST /teachings
  def create
    @teaching = @classroom.teachings.build(
      teacher: User.find_by(email: teaching_params[:user_id]),
      subject_id: teaching_params[:subject_id],
      all_subjects: teaching_params[:all_subjects])

    authorize @teaching

    if @teaching.save
      redirect_to @teaching, notice: 'Teaching was successfully added.'
    else
      render :new
    end
  end

  # PATCH/PUT /teachings/1
  def update
    authorize @teaching

    if @teaching.update(update_teaching_params)
      redirect_to @teaching, notice: 'Teaching was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /teachings/1
  def destroy
    authorize @teaching
    @teaching.destroy

    redirect_to classroom_teachings_url(@classroom), notice: 'Teaching was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_teaching
    @teaching = Teaching.find(params[:id])
  end

  def set_classroom
    @classroom = @teaching.classroom
  end

  def set_classroom_from_params
    @classroom = Classroom.find(params[:classroom_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def teaching_params
    params.require(:teaching).permit(:user_id, :classroom_id, :subject_id, :all_subjects)
  end

  def update_teaching_params
    params.require(:teaching).permit(:classroom_id, :subject_id, :all_subjects)
  end
end
