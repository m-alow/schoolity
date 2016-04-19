class SchoolClassesController < ApplicationController
  before_action :set_school_class, only: [:show, :edit, :update, :destroy]
  before_action :set_school_from_params, only: [:index, :new, :create]
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  def index
    @school_classes = SchoolClass.all
  end

  def show
  end

  def new
    @school_class = SchoolClass.new
  end

  def edit
  end

  def create
    @school_class = SchoolClass.new(school_class_params)

    respond_to do |format|
      if @school_class.save
        format.html { redirect_to @school_class, notice: 'School class was successfully created.' }
        format.json { render :show, status: :created, location: @school_class }
      else
        format.html { render :new }
        format.json { render json: @school_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @school_class.update(school_class_params)
        format.html { redirect_to @school_class, notice: 'School class was successfully updated.' }
        format.json { render :show, status: :ok, location: @school_class }
      else
        format.html { render :edit }
        format.json { render json: @school_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @school_class.destroy
    respond_to do |format|
      format.html { redirect_to school_school_classes_url(@school), notice: 'School class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school_class
      @school_class = SchoolClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_class_params
      params.require(:school_class).permit(:school_id, :name)
    end

    def set_school
      @school = @school_class.school
    end

    def set_school_from_params
      @school = School.find(params[:school_id])
    end
end
