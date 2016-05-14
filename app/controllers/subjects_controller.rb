class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :set_school_class, only: [:show, :edit, :update, :destroy]
  before_action :set_school_class_from_params, only: [:index, :new, :create]
  after_action :verify_authorized, except: :index

  # GET school_classes/1/subjects
  def index
    SubjectPolicy.new(current_user, @school_class).authorize_action(:index?)
    @subjects = @school_class.subjects
  end

  # GET /subjects/1
  def show
    authorize @subject
  end

  # GET school_classes/1/subjects/new
  def new
    @subject = @school_class.subjects.build
    authorize @subject
  end

  # GET /subjects/1/edit
  def edit
    authorize @subject
  end

  # POST /school_classes/1/subjects
  def create
    @subject = @school_class.subjects.build(subject_params)
    authorize @subject
    if @subject.save
      redirect_to @subject, notice: 'Subject was successfully added.'
    else
      render :new
    end
  end

  # PATCH/PUT /subjects/1
  def update
    authorize @subject
    if @subject.update(subject_params)
      redirect_to @subject, notice: 'Subject was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /subjects/1
  def destroy
    authorize @subject
    @subject.destroy
    redirect_to school_class_subjects_url(@school_class), notice: 'Subject was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_subject
    @subject = Subject.find(params[:id])
  end

  def set_school_class
    @school_class = @subject.school_class
  end

  def set_school_class_from_params
    @school_class = SchoolClass.find(params[:school_class_id])
  end

  # never trust parameters from the scary internet, only allow the white list through.
  def subject_params
    params.require(:subject).permit(:name)
  end
end
