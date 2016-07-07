module Api
  module V1
    module Parent
      class FeedController < ApiController
        FeedEntry = Struct.new(:type, :entry)
        def index
          feed = current_user
                 .parent_feed
                 .map { |_, f| { type: f.class.name, entry: ActiveModelSerializers::SerializableResource.new(f) } }

          respond_to do |format|
            format.json { render json: feed }
          end
        end
      end
    end
  end
end
