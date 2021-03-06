class Schools::AnnouncementsController < ApplicationController
  before_action :set_school_from_params, only: [:index, :new, :create]

  # GET /schools/1/announcements
  def index
    SchoolAnnouncementPolicy.new(current_user, @school).authorize_action(:index?)
    @announcements = @school.announcements
  end

  # GET /schools/1/announcements/new
  def new
    @announcement = @school.announcements.build(author: current_user)
    authorize @announcement
  end

  # POST /schools/1/announcements
  def create
    Announcements::PostOnSchool.(@school, current_user, params[:announcement]) do
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
  def set_school_from_params
    @school = School.find params[:school_id]
  end
end
