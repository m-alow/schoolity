module Api
  module V1
    module Parent
      class NotificationsController < ApiController
        def index
          notifications = current_user.parent_notifications.sorted.paginate(page: params[:page], per_page: 10)
          respond_to do |format|
            format.json { render json: notifications }
          end
        end
      end
    end
  end
end
