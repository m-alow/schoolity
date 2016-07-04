require_dependency 'scope/school/followers'

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
    @announcement = @school.announcements.build(create_announcement_params)

    authorize @announcement

    if @announcement.save
      CreateNotifier
        .new(Scope::School::Followers.new @school)
        .call @announcement

      redirect_to @announcement, notice: 'Announcement was successfully created.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_school_from_params
    @school = School.find params[:school_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def create_announcement_params
    params.require(:announcement).permit(:title, :body).merge( { author: current_user })
  end
end
