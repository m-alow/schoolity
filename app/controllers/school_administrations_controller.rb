class SchoolAdministrationsController < ApplicationController
  before_action :set_school_administration, only: [:show, :destroy]
  before_action :set_school_from_params, only: [:index, :new, :create]
  before_action :set_school, only: [:show, :destroy]
  after_action :verify_authorized, except: [:index]

  # GET /schools/1/school_administrations
  def index
    SchoolAdministrationPolicy.new(current_user, @school).authorize_action(:index?)
    @school_administrations = SchoolAdministration.all
  end

  # GET /school_administrations/1
  def show
    authorize @school_administration
  end

  # GET /schools/1/school_administrations/new
  def new
    @school_administration = @school.school_administrations.build
    authorize @school_administration
  end

  # POST /schools/1/school_administrations
  def create
    @school_administration = @school.school_administrations.build
    authorize @school_administration
    @school_administration.administrator = User.find_by(email: params[:email])

    if @school_administration.save
      redirect_to @school_administration, notice: 'School administration was successfully added.'
    else
      render :new
    end
  end

  # DELETE /school_administrations/1
  def destroy
    authorize @school_administration
    @school_administration.destroy
    redirect_to school_school_administrations_url(@school), notice: 'School administration was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_school_from_params
    @school = School.find(params[:school_id])
  end

  def set_school
    @school = @school_administration.administrated_school
  end

  def set_school_administration
    @school_administration = SchoolAdministration.find(params[:id])
  end
end
