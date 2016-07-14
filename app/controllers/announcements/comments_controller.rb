class Announcements::CommentsController < ApplicationController
  # POST /announcements/1/comments
  def create
    announcement = Announcement.find params[:announcement_id]
    authorize announcement, :show?

    respond_to do |format|
      Commenting::CommentOnAnnouncement.call(announcement, current_user, params[:comment][:body]) do

        on(:success) do |comment|
          format.html { redirect_to announcement, notice: 'Comment was successfully added.' }
          format.js { render 'comments/create', locals: { comment: comment } }
        end

        on(:invalid) do
          format.html { redirect_to announcement, notice: 'Comment was not added.' }
          format.js { render nothing: true }
        end
      end
    end
  end
end
