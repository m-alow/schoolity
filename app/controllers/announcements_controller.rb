class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]
  before_action :set_announceable, only: [:show, :edit, :update, :destroy]

  # GET /announcements/1
  def show
    authorize @announcement
  end

  # GET /announcements/1/edit
  def edit
    authorize @announcement
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

    if @announcement.for_school?
      redirect_to school_announcements_url(@announceable), notice: 'Announcement was successfully destroyed.'
    elsif @announcement.for_school_class?
      redirect_to school_class_announcements_url(@announceable), notice: 'Announcement was successfully destroyed.'
    elsif @announcement.for_classroom?
      redirect_to classroom_announcements_url(@announceable), notice: 'Announcement was successfully destroyed.'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def set_announceable
    @announceable = @announcement.announceable
  end

  def update_announcement_params
    params.require(:announcement).permit(:title, :body)
  end
end
