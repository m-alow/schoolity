module Api
  module V1
    module Parent
      class FeedController < ApiController
        FeedEntry = Struct.new(:type, :entry)
        def index
          notifications = current_user.parent_notifications.paginate page: params[:page]
          feed = current_user
                 .parent_feed(notifications)
                 .map { |_, f| { type: f.class.name, entry: ActiveModelSerializers::SerializableResource.new(f, user_id: current_user.id) } }

          respond_to do |format|
            format.json { render json: feed }
          end
        end
      end
    end
  end
end
