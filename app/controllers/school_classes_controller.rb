class SchoolClassesController < ApplicationController
  before_action :set_school_class, only: [:show, :edit, :update, :destroy]
  before_action :set_school_from_params, only: [:index, :new, :create]
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:index]

  def index
    SchoolClassPolicy.new(current_user, @school).authorize_action(:index?)
    @school_classes = SchoolClass.all
  end

  def show
    authorize @school_class
  end

  def new
    @school_class = @school.school_classes.new
    authorize @school_class
  end

  def edit
    authorize @school_class
  end

  def create
    @school_class = @school.school_classes.build(school_class_params)
    authorize @school_class

    if @school_class.save
      redirect_to @school_class, notice: 'School class was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @school_class
    if @school_class.update(school_class_params)
      redirect_to @school_class, notice: 'School class was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @school_class
    @school_class.destroy
    redirect_to school_school_classes_url(@school), notice: 'School class was successfully destroyed.'
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
