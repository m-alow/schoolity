class Students::AnnouncementsController < ApplicationController
  before_action :set_student_from_params, only: [:index, :new, :create]

  # GET /studentes/1/announcements
  def index
    StudentAnnouncementPolicy.new(current_user, @student).authorize_action(:index?)
    @announcements = @student.announcements
  end

  # GET /studentes/1/announcements/new
  def new
    @announcement = @student.announcements.build(author: current_user)
    authorize @announcement
  end

  # POST /studentes/1/announcements
  def create
    Announcements::PostOnStudent.(@student, current_user, params[:announcement]) do
      on(:success) do |announcement|
        redirect_to announcement, notice: 'Announcement was successfully created.'
      end

      on(:invalid) do |announcement|
        @announcement = announcement
        render :new
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_student_from_params
    @student = Student.find params[:student_id]
  end
end
