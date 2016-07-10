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
    @announcement = @student.announcements.build(announcement_params)
    authorize @announcement

    if @announcement.save
      Notifier::Create
        .new(Scope::Student::Followers.new(@student))
        .call @announcement

      redirect_to @announcement, notice: 'Announcement was successfully created.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_student_from_params
    @student = Student.find params[:student_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def announcement_params
    params.require(:announcement).permit(:title, :body).merge({ author: current_user })
  end
end
