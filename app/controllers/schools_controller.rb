class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy, :activate]
  after_action :verify_authorized

  # GET /schools
  def index
    authorize School
    @schools = policy_scope(School)
  end

  # GET /schools/1
  def show
    authorize @school
  end

  # GET /schools/new
  def new
    authorize School
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
    authorize @school
  end

  # POST /schools
  def create
    authorize School
    @school = School.new(school_params) do |u|
      u.owner = current_user
    end

    if @school.save
      redirect_to @school, notice: 'School was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /schools/1
  def update
    authorize @school
    if @school.update(school_params)
      redirect_to @school, notice: 'School was successfully updated.'
    else
      render :edit
    end
  end

  def activate
    authorize @school
    if @school.update(school_activation_params)
      redirect_to @school, notice: 'School was successfully activated.'
    else
      redirect_to schools_path, notice: 'School can not be activated.'
    end
  end

  # DELETE /schools/1
  def destroy
    authorize @school
    @school.destroy
    redirect_to schools_url, notice: 'School was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_school
    @school = School.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def school_params
    params.require(:school).permit(:name)
  end

  def school_activation_params
    params.require(:school).permit(:active)
  end
end
