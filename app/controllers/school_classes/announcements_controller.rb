require_dependency 'notifier/notify'
require_dependency 'scope/school_class/followers'
require_dependency 'notifier/publishers/persist/create'

class SchoolClasses::AnnouncementsController < ApplicationController
  before_action :set_school_class_from_params, only: [:index, :new, :create]

  # GET /school_classes/1/announcements
  def index
    SchoolClassAnnouncementPolicy.new(current_user, @school_class).authorize_action(:index?)
    @announcements = @school_class.announcements
  end

  # GET /school_classes/1/announcements/new
  def new
    @announcement = @school_class.announcements.build(author: current_user)
    authorize @announcement
  end

  # POST /school_classes/1/announcements
  def create
    @announcement = @school_class.announcements.build(announcement_params)
    authorize @announcement

    if @announcement.save
      Notify
        .new(Scope::SchoolClass::Followers.new(@school_class),
                 [Notifier::Publishers::Persist::Create.new])
        .call @announcement

      redirect_to @announcement, notice: 'Announcement was successfully created.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_school_class_from_params
    @school_class = SchoolClass.find params[:school_class_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def announcement_params
    params.require(:announcement).permit(:title, :body).merge({ author: current_user })
  end
end
