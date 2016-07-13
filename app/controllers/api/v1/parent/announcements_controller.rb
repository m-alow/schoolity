module Api
  module V1
    module Parent
      class AnnouncementsController < ApiController
        def index
          announcements = current_user
                          .parent_notifications
                          .where(notifiable_type: 'Announcement')
                          .map(&:notifiable)

          respond_to do |format|
            format.json { render json: announcements, status: :ok }
          end
        end
      end
    end
  end
end
