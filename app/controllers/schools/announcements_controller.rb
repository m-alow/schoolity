class Schools::AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :set_school_from_params, only: [:index, :new, :create]

  # GET /schools/1/announcements
  def index
    SchoolAnnouncementPolicy.new(current_user, @school).authorize_action(:index?)
    @schools_announcements = @school.announcements
  end

  # GET /announcements/1
  def show
    authorize @announcement
  end

  # GET /schools/1/announcements/new
  def new
    @announcement = @school.announcements.build(author: current_user)
    authorize @announcement
  end

  # GET /announcements/1/edit
  def edit
    authorize @announcement
  end

  # POST /schools/1/announcements
  def create
    @announcement = @school.announcements.build(create_announcement_params)

    authorize @announcement

    if @announcement.save
      redirect_to @announcement, notice: 'Announcement was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /announcements/1
  def update
    authorize @announcement

    if @announcement.update(update_announcement_params)
      redirect_to @announcement, notice: 'Announcement was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /announcements/1
  def destroy
    authorize @announcement
    @announcement.destroy
    redirect_to school_announcements_url(@school), notice: 'Announcement was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    def set_school
      @school = @announcement.announceable
    end

    def set_school_from_params
      @school = School.find params[:school_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_announcement_params
      params.require(:announcement).permit(:title, :body).merge( { author: current_user })
    end

    def update_announcement_params
      params.require(:announcement).permit(:title, :body)
    end
end
