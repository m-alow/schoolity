module Api
  module V1
    module Parent
      module Announcements

        class CommentsController < ApiController
          def index
            announcement = Announcement.find params[:announcement_id]

            respond_to do |format|
              format.json { render json: announcement.comments, status: :ok, current_user: current_user.id  }
            end
          end

          def create
            announcement = Announcement.find params[:announcement_id]
            respond_to do |format|
              Commenting::CommentOnAnnouncement.call(announcement, current_user, params[:comment][:body]) do
                on(:success) do |comment|
                  format.json { render json: comment, status: :ok, current_user: current_user.id  }
                end
                on(:invalid) do
                  format.json { render json: { errors: ['Comment cannot be blank.'] }, status: :unprocessable_entity }
                end
              end
            end
          end
        end

      end
    end
  end
end
