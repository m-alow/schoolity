class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]
  before_action :set_school_class_from_params, only: [:index, :new, :create]
  before_action :set_school_class, only: [:show, :edit, :update, :destroy]
  before_action :set_school

  def index
    @classrooms = Classroom.all
  end

  def show
  end

  def new
    @classroom = Classroom.new
  end

  def edit
  end

  def create
    @classroom = Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: 'Classroom was successfully created.' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
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
