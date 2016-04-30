class SchoolAdministrationsController < ApplicationController
  before_action :set_school_from_params, only: [:index, :new, :create]
  before_action :set_school_administration, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /schools/1/school_administrations
  def index
    authorize @school
    @school_administrations = SchoolAdministration.all
  end

  # GET /school_administrations/1
  def show
    authorize @school_administration
  end

  # GET /schools/1/school_administrations/new
  def new
    @school_administration = SchoolAdministration.new
    authorize @school_administration
  end

  # GET /school_administrations/1/edit
  def edit
    authorize @school_administration
  end

  # POST /schools/1/school_administrations
  def create
    @school_administration = SchoolAdministration.new(school_administration_params)
    authorize @school_administration

    if @school_administration.save
      redirect_to @school_administration, notice: 'School administration was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /school_administrations/1
  def update
    if @school_administration.update(school_administration_params)
      redirect_to @school_administration, notice: 'School administration was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /school_administrations/1
  def destroy
    authorize @school_administration
    @school_administration.destroy
    redirect_to school_administrations_url, notice: 'School administration was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_school_from_params
    @school = School.find(params[:school_id])
  end

  def set_school_administration
    @school_administration = SchoolAdministration.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def school_administration_params
    params.require(:school_administration).permit(:user_id, :school_id)
  end
end
