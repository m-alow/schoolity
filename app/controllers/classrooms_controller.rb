class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]
  before_action :set_school_class_from_params, only: [:index, :new, :create]
  before_action :set_school_class, only: [:show, :edit, :update, :destroy]
  before_action :set_school
  after_action :verify_authorized, except: :index

  def index
    ClassroomPolicy.new(current_user, @school).authorize_action(:index?)

    @classrooms = @school_class.classrooms
  end

  def show
    authorize @classroom
  end

  def new
    @classroom = @school_class.classrooms.build
    authorize @classroom
  end

  def edit
    authorize @classroom
  end

  def create
    @classroom = @school_class.classrooms.build(classroom_params)
    authorize @classroom

    if @classroom.save
      redirect_to @classroom, notice: 'Classroom was successfully added.'
    else
      render :new
    end
  end

  def update
    authorize @classroom
    if @classroom.update(classroom_params)
      redirect_to @classroom, notice: 'Classroom was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @classroom
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to school_class_classrooms_url(@school_class), notice: 'Classroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    def set_school_class_from_params
      @school_class = SchoolClass.find(params[:school_class_id])
    end

    def set_school_class
      @school_class = @classroom.school_class
    end

    def set_school
      @school = @school_class.school
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:school_class_id, :name)
    end
end
