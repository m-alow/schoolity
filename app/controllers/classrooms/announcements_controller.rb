require_dependency 'scope/classroom/followers'

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
    @announcement = @classroom.announcements.build(announcement_params)
    authorize @announcement

    if @announcement.save
      followers_scope = Scope::Classroom::Followers.new
      followers_scope.call(@classroom).each do |user|
        Notification.create notifiable: @announcement,
                            recipient: user,
                            recipient_role: followers_scope.role,
                            actor: current_user
      end

      redirect_to @announcement, notice: 'Announcement was successfully created.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_classroom_from_params
    @classroom = Classroom.find params[:classroom_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def announcement_params
    params.require(:announcement).permit(:title, :body).merge({ author: current_user })
  end
end
