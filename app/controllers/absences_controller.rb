class AbsencesController < ApplicationController
  before_action :set_day, except: [:destroy, :show]

  # GET /days/:day_id/absences
  def index
    AbsencePolicy.new(current_user, @day).authorize_action(:index?)
    @absences = ClassroomAbsences.new.(@day)
  end

  # GET /absences/1
  def show
    @absence = Absence.find params[:id]
    authorize @absence
  end

  # GET /days/:day_id/students/:student_id/absence
  def update
    @student = Student.find params[:student_id]
    AbsencePolicy.new(current_user, Absence.new(student: @student, day: @day)).authorize_action(:update?)

    absence = Absence.find_by day: @day, student: @student
    unless absence.present?
      absence = @day.absences.create student: @student
    end

    absence.update(notes: params[:absence][:notes])

    notify_followers absence

    respond_to do |format|
      format.html { redirect_to day_absences_url(@day) }
      format.js { render locals: { absence: absence } }
    end
  end

  # DELETE /absences/1
  def destroy
    absence = Absence.find params[:id]
    authorize absence
    absence.destroy

    respond_to do |format|
      format.html { redirect_to day_absences_url(absence.day) }
      format.js { render :update, locals: { absence: absence } }
    end
  end

  private

  def set_day
    @day = Day.find params[:day_id]
    @classroom = @day.classroom
  end

  def notify_followers absence
    Notifier::Update
      .new(Scope::Student::Followers.new(@student))
      .call absence
  end
end
