class Classrooms::AnnouncementsController < ApplicationController
  before_action :set_classroom_from_params, only: [:index, :new, :create]

  # GET /classroomes/1/announcements
  def index
    ClassroomAnnouncementPolicy.new(current_user, @classroom).authorize_action(:index?)
    @announcements = @classroom.announcements
  end

  # GET /classroomes/1/announcements/new
  def new
    @announcement = @classroom.announcements.build(author: current_user)
    authorize @announcement
  end

  # POST /classroomes/1/announcements
  def create
    Announcements::PostOnClassroom.(@classroom, current_user, params[:announcement]) do
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
  def set_classroom_from_params
    @classroom = Classroom.find params[:classroom_id]
  end
end
